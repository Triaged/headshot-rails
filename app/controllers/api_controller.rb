class APIController < ApplicationController
  respond_to :json
  protect_from_forgery with: :null_session
  skip_before_filter :validate_subdomain
  before_filter :authenticate_user_from_token!, :except => [:page_not_found]
  before_filter :authenticate_user!
  before_filter :current_company
  rescue_from ActiveRecord::RecordNotFound,
              ActionController::RoutingError,
              ::AbstractController::ActionNotFound, :with => :page_not_found

  protected

  def current_company
  	current_user.company
  end

  def page_not_found
    render :json => { :errors => ['Page not found'] }, :status => 404
  end

  def authenticate_user_from_token!
    user_token = request.headers["HTTP_AUTHORIZATION"].presence
    user = user_token && User.find_by(authentication_token: user_token)
    sign_in user if user
  rescue
    # find_by fails with an invalid token
  end

end