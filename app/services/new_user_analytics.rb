class NewUserAnalytics
  include Sidekiq::Worker

  def perform(user_id)
  	user = User.find(user_id)
  	Analytics.identify(
    user_id: user.id,
    traits: {
      name: user.full_name,
      email: user.email,
      created_at: DateTime.now,
      company: user.company.name,
      company_id: user.company_id
    })
    Analytics.track(
      user_id: user.id,
      event: 'user_invited',
       properties: {
        admin: user.company.admin_user.id,
        admin_name: user.company.admin_user.full_name,
        "company.id" => user.company.id,
        "company.name" => user.company.name
      },
      context: {
        traits: { company_id: user.company.id, company_name: user.company.name }
      }
    )
  end
end