class HomeController < ApplicationController
	skip_before_filter :authenticate_user!
	before_action :require_no_authentication

	layout "home"

	def index
	end

end
