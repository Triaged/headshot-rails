class AdminController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authenticate_admin!

private
	def authenticate_admin!
		current_user.admin?
	end
end
