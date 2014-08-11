require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "import_failed" do
    mail = AdminMailer.import_failed
    assert_equal "Import failed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
