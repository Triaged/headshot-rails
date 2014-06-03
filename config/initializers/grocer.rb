GROCER = ConnectionPool.new(:size => 5, :timeout => 5) { 
	Grocer.pusher(
	  certificate: Rails.root + "headshot-dev-apns.pem",      # required
	  passphrase:  "snowboard12",                       # optional
	  gateway:     "gateway.sandbox.push.apple.com", # optional; See note below.
	  port:        2195,                     # optional
	  retries:     3                         # optional
	) 
}

 
GROCER_FEEDBACK = Grocer.feedback(
  certificate: Rails.root + "headshot-dev-apns.pem",       # required
  passphrase:  "snowboard12",                        # optional
  gateway:     "feedback.sandbox.push.apple.com", # optional; See note below.
  port:        2196,                      # optional
  retries:     3                          # optional
)