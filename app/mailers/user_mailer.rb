class UserMailer < Devise::Mailer   
	include Sidekiq::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  def confirmation_instructions(record, token, opts={})
  	mail = super
    # your custom logic
    admin = record.company.admin_user
		mail.subject = "Your colleague, #{admin.full_name}, has invited you to Badge!"

    mail
	end
end