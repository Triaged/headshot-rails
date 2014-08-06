class API::V1::VersionsController < APIController
	skip_before_filter :authenticate_user_from_token!
  skip_before_filter :authenticate_user!
  skip_before_filter :current_company

	def ios
		render :json => { "version" => "12" }, :status => 200
	end

	def android
		render :json => { "version" => "0" }, :status => 200
	end
end
