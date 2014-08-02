class UserMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  def confirmation_instructions(record, token, opts={})
  	mail = super
    # your custom logic
    show_admin = record.admin ? true : false

    unless show_admin
      admin = record.company.admin_user
  		mail.subject = "#{admin.first_name.capitalize} invited you to Badge!"
  	else
      mail.subject = "Welcome to Badge!"
      mail.template = "confirmation_instructions_admin"
    end

    mail.from = "\"#{admin.full_name} via Badge\" <team@badge.co>"

    mail
	end
end