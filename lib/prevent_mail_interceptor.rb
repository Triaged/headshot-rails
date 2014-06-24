class PreventMailInterceptor

  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "dev-test@badge.co"
  end
end