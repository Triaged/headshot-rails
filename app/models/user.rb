class User < ActiveRecord::Base
	acts_as_paranoid
	extend FriendlyId
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :omniauthable,# :confirmable,
		:recoverable, :rememberable, :trackable, :validatable, :async


	before_save :ensure_authentication_token!

	belongs_to :company
	belongs_to :department, counter_cache: true
	belongs_to :manager, class_name: "User"

	has_many :provider_credentials
	has_many :devices
	has_many :subordinates, class_name: "User", foreign_key: "manager_id", dependent: :nullify

	belongs_to :primary_office_location, class_name: "OfficeLocation"
	belongs_to :current_office_location, class_name: 'OfficeLocation'

	has_one :employee_info
	accepts_nested_attributes_for :employee_info, update_only: true
	has_one :home_location


	mount_uploader :avatar, AvatarUploader

	#before_create :set_company
	before_create :create_default_employee_info
	after_create :set_defaults
	#after_create :push_entity TODO: REVISIT!
	before_destroy :remove_edges



	validates :first_name, presence: true
	validates :last_name, presence: true

	default_scope { includes(:employee_info) }
	scope :admin, -> { where(admin: true) }

	friendly_id :full_name, :use => [:slugged, :finders, :scoped], :scope => :company

	def full_name
		"#{first_name.capitalize} #{last_name.capitalize}"
	end

	def initials
		"#{first_name[0].capitalize}#{last_name[0].capitalize}"
	end

	def set_company
		email_address = Mail::Address.new(email)

		if is_email_personal(email_address)
			return false
		else
			company_name = PublicSuffix.parse(email_address.domain).sld
			self.company = Company.find_or_create_by(name: company_name)
		end
	end

	def is_email_personal email_address
		text=File.open("#{Rails.root}/emails.txt").read
		text.each_line do |line|
			return true if (email_address.domain == line.strip)
		end
		false
	end

	def save_omniauth(provider, uid, access_token, refresh_token=nil)
		credentials = self.provider_credentials.find_or_create_by(company: company, provider: Provider.named(provider), uid: uid)
		credentials.access_token = access_token
		credentials.refresh_token = refresh_token
		credentials.save!
		return credentials
	end

	# new function to set the password without knowing the current password used in our confirmation controller.
	def attempt_set_password(params)
		p = {}
		p[:password] = params[:password]
		p[:password_confirmation] = params[:password_confirmation]
		update_attributes(p)
	end
	# new function to return whether a password has been set
	def has_no_password?
		self.encrypted_password.blank?
	end

	def only_if_unconfirmed
		pending_any_confirmation {yield}
	end

	def password_required?
		# Password is required if it is being set, but not for new records
		if !persisted?
			false
		else
			!password.nil? || !password_confirmation.nil?
		end
	end

	def ensure_authentication_token!
		if authentication_token.blank?
			self.authentication_token = generate_authentication_token
		end
	end

	def password_match?
		self.errors[:password] << 'must be provided' if password.blank?
		self.errors[:password] << 'and confirmation do not match' if password != password_confirmation
		password == password_confirmation and !password.blank?
	end

	def installed_app?
		self.devices.count > 0
	end

	def can_receive_push?
		self.installed_app? && (self.devices.where.not(token: nil).count > 0) && (self.devices.where(logged_in: true).count > 0)
	end

	def set_defaults
		NewUserAnalytics.perform_async(self.id)
		unleash_sherlock
	end

	def push_entity
		EntityPush.perform_async(self.company.id, "user", self.id)
	end

	def unleash_sherlock
		SherlockHolmes.perform_async(self.id)
		true
	end


	protected

	def remove_edges
		# do stuff
		self.department = nil
	end


	def create_default_employee_info
		# build default profile instance. Will use default params.
		# The foreign key to the owning User model is set automatically
		create_employee_info if employee_info.nil?
		true # Always return true in callbacks as the normal 'continue' state
	end


	def generate_authentication_token
		loop do
			token = Devise.friendly_token
			break token unless User.where(authentication_token: token).first
		end
	end

end
