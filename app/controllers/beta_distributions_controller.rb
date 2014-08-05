class BetaDistributionsController < ApplicationController
	skip_before_filter :authenticate_user!
	layout false

	def show
		@platform = :android if browser.android?
		@platform = :ios if browser.ios?
	end
end
