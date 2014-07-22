class InternalAPIController < ApplicationController
	respond_to :json
  protect_from_forgery with: :null_session
  skip_before_filter :validate_subdomain
  before_filter :authenticate_from_token!, :except => [:page_not_found]
  
  protected

  def page_not_found
    render :json => { :errors => ['Page not found'] }, :status => 404
  end

  def authenticate_from_token!
    user_token = request.headers["HTTP_AUTHORIZATION"].presence
    user_token && (user_token == ENV["INTERNAL_API_TOKEN"])
  rescue
    # find_by fails with an invalid token
    false
  end

end
