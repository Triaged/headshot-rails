# app/workers/hard_worker.rb
class EntityPush
  include Sidekiq::Worker

  def perform(company_id, type, id)
  	users = Company.find(company_id).users
		devices = users.collect {|user| user.devices.where(service: 'android').all }.flatten.to_a.uniq{ |device| device.token }
		client = AWS::SNS::Client.new

		devices.each do |device|
			begin
				gcm_payload = {data: {type: type, id: id.to_s}}.to_json
				message = { "default" => "new entity", "GCM" => gcm_payload }.to_json
				client.publish( message: message, target_arn: device.arn, message_structure: 'json' )
			rescue
				next
			end
		end
  end
end