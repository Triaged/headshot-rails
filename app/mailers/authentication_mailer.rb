class AuthenticationMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.authentication_mailer.challenge.subject
  #
  def challenge( id )
    @user = User.find( id )
    mail to: @user.email
  end
end
