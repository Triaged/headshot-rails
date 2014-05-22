class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :basecamper
	devise_basecamper :subdomain_class => :company, :subdomain_field => :slug, :scope_field => :company_id
	before_save :ensure_authentication_token!	

  belongs_to :company
  has_one :employee_info, dependent: :destroy
  accepts_nested_attributes_for :employee_info
  has_many :provider_credentials
  has_many :subordinates, class_name: "User", foreign_key: "manager_id"
 	belongs_to :manager, class_name: "User"

  mount_uploader :avatar, AvatarUploader

  before_create :set_company

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

 
protected

	
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
