class FullContactController < ApplicationController
	skip_before_filter :authenticate_user!

	def create
		user = User.find(params[:webhookId])
		FullContactService.new(@user).parse_results params[:result]
		render :json => { "message" => "ok" }, :status => 200
	end


end
