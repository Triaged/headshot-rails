class FullContactController < ApplicationController
	skip_before_filter :authenticate_user!
	protect_from_forgery except: :create

	def create
		user = User.find(params[:webhookId])
		FullContactService.new(@user).parse_results params[:result]
		render :json => { "message" => "ok" }, :status => 200
	end


end
