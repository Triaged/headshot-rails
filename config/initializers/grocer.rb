GROCER = ConnectionPool.new(:size => 5, :timeout => 5) { 
	Grocer.pusher(
	  certificate: Rails.root + ENV["GROCER_CERT"],      # required
	  passphrase:  ENV["GROCER_PASS"],                       # optional
	  gateway:     ENV["GROCER_ENDPOINT"], # optional; See note below.
	  port:        2195,                     # optional
	  retries:     3                         # optional
	) 
}

 
GROCER_FEEDBACK = Grocer.feedback(
  certificate: Rails.root + ENV["GROCER_CERT"],       # required
  passphrase:  ENV["GROCER_PASS"],                        # optional
  gateway:     ENV["GROCER_ENDPOINT"], # optional; See note below.
  port:        2196,                      # optional
  retries:     3                          # optional
)