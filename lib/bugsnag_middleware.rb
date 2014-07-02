class BugsnagMiddleware
  def initialize(bugsnag)
    @bugsnag = bugsnag
  end

  def call(notification)
    # Your custom "before notify" code

    @bugsnag.call(notification)

    # Your custom "after notify" code
  end
end