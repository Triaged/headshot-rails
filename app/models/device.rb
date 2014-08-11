class Device < ActiveRecord::Base

	belongs_to :user, counter_cache: true
	
	validates :application_id, presence: true
	#validates :token, uniqueness: true

	before_save :strip_spaces
	before_save :create_sns_endpoint
	after_create :track_device

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

  def delete_sns_endpoint
  	return if self.arn.nil?
  	client = AWS::SNS.new.client
  	response = client.delete_endpoint(endpoint_arn: self.arn)
  end

  def track_device
  	DeviceAnalytics.perform_async(self.user.id)
  end

end
