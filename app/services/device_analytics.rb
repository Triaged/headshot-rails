class DeviceAnalytics
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
  	Analytics.track(
      user_id: user.id,
      event: 'device_added',
      properties: {
        service: self.service,
        os_version: self.os_version,
         "company.id" => user.company.id,
         "company.name" => user.company.name
      },
      context: {
        traits: { company_id: user.company.id, company_name: user.company.name }
      }
    )
  end
end