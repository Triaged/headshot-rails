require 'test_helper'

class AuthenticationMailerTest < ActionMailer::TestCase
  test "challenge" do
    mail = AuthenticationMailer.challenge
    assert_equal "Challenge", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
