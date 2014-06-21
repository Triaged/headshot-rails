class User < ActiveRecord::Base
	acts_as_paranoid
	# Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
	
	
	before_save :ensure_authentication_token!	

  belongs_to :company
  belongs_to :department, counter_cache: true
  belongs_to :manager, class_name: "User"
  
	has_many :provider_credentials
	has_many :devices
  has_many :subordinates, class_name: "User", foreign_key: "manager_id"

  belongs_to :primary_office_location, class_name: "OfficeLocation"
	belongs_to :current_office_location, class_name: 'OfficeLocation'
 	
 	has_one :employee_info
 	accepts_nested_attributes_for :employee_info
	
	mount_uploader :avatar, AvatarUploader

  #before_create :set_company
  before_create :create_default_employee_info
  after_create :unleash_sherlock

  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :admin, -> { where(admin: true) }

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

 
protected

	def unleash_sherlock
		SherlockHolmes.new(self.id).investigate!
		true
	end


	def create_default_employee_info
	  # build default profile instance. Will use default params.
	  # The foreign key to the owning User model is set automatically
	  create_employee_info
	  true # Always return true in callbacks as the normal 'continue' state
	end


  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
