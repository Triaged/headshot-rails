class SessionAnalytics
  include Sidekiq::Worker

  def perform(user_id)
  	user = User.find(user_id)
  	Intercom::User.create(:user_id => user.id, :name => user.full_name, update_last_request_at:1)
  end
end