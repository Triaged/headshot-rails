class RetentionMailer < ActionMailer::Base
  
  def first(user_id)
    @recipient = User.find(user_id)

    @token, secure_token = Devise.token_generator.generate(User, :confirmation_token)
    @recipient.update_attributes(confirmation_token: secure_token)

    mail(to: @recipient.email, from:  "\"Badge Team\" <team@badge.co>", 
          subject: "Your invitation to Badge is waiting.")
  end

  def second(user_id)
    @recipient = User.find(user_id)

    @token, secure_token = Devise.token_generator.generate(User, :confirmation_token)
    @recipient.update_attributes(confirmation_token: secure_token)

    mail(to: @recipient.email, from:  "\"Badge Team\" <team@badge.co>", 
          subject: "Your invitation to Badge is waiting.")
  end

  
end
