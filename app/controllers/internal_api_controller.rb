class InternalAPIController < ApplicationController
	respond_to :json
  protect_from_forgery with: :null_session
  skip_before_filter :authenticate_user!, :validate_subdomain
  before_filter :authenticate_from_token!, :except => [:page_not_found]
  
  protected

  def page_not_found
    render :json => { :errors => ['Page not found'] }, :status => 404
  end

  def authenticate_from_token!
    user_token = request.headers["HTTP_AUTHORIZATION"].presence
    unless user_token && (user_token == ENV["INTERNAL_API_TOKEN"])
      render :json => { :errors => ['You must be signed in to access this page'] }, :status => 401
    end
  rescue
    # find_by fails with an invalid token
    render :json => { :errors => ['You must be signed in to access this page'] }, :status => 401
  end

end
