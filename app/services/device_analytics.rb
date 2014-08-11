class DeviceAnalytics
  include Sidekiq::Worker

  def perform(device_id)
    device = Device.find(device_id)
  	Analytics.track(
      user_id: device.user.id,
      event: 'device_added',
      properties: {
        service: device.service,
        os_version: device.os_version,
         "company.id" => device.user.company.id,
         "company.name" => device.user.company.name
      },
      context: {
        traits: { company_id: device.user.company.id, company_name: device.user.company.name }
      }
    )
  end
end