class UserMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  def confirmation_instructions(record, token, opts={})
  	mail = super
    # your custom logic
    admin = record.company.admin_user
		mail.subject = "#{admin.first_name.capitalize} invited you to Badge!"
		mail.from = "\"#{admin.full_name} via Badge\""

    mail
	end
end