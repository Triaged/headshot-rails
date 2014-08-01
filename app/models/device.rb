class Device < ActiveRecord::Base

	belongs_to :user, counter_cache: true
	
	validates :application_id, presence: true
	#validates :token, uniqueness: true

	before_save :strip_spaces
	before_save :create_sns_endpoint

  def strip_spaces
  	token.delete(' ') if token
  end

  def create_sns_endpoint
  	return unless self.token_changed?
  	client = AWS::SNS.new.client

  	if self.service == "ios"
	  	response = client.create_platform_endpoint(
			  platform_application_arn: "arn:aws:sns:us-west-2:297824293218:app/APNS/badge-staging",
			  token: self.token
			)
		else
			response = client.create_platform_endpoint(
			  platform_application_arn: "arn:aws:sns:us-west-2:297824293218:app/GCM/badge-staging-cgm",
			  token: self.token
			)
		end

		self.arn = response[:endpoint_arn]
  end

end
