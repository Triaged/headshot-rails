class AdminMailer < ActionMailer::Base
  default from: "team@badge.co"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.import_failed.subject
  #
  def import_failed(user_id)
    @user = User.find(user_id)

    mail to: "team@badge.co", subject: "Google App Import Failed"
  end
end
