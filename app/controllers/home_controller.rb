class HomeController < ApplicationController
	skip_before_filter :authenticate_user!
	layout "home"

	def create
	end

	def users
	end

	def user
	end

	def prompt_import
	end

	def import
	end

	def profile
	end

	def company
	end

	def add
	end

end
