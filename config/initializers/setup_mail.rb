ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "headshot.io",
  :user_name            => "charlie@headshot.io",
  :password             => "Snowboard12",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "headshotapp.herokuapp.com"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?