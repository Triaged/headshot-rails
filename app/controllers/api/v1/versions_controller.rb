class API::V1::VersionsController < ApplicationController

	def ios
		render :json => { "version" => "5" }, :status => 200
	end

	def android
		render :json => { "version" => "5" }, :status => 200
	end
end
