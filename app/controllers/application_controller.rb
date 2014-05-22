class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include UrlHelper
  protect_from_forgery with: :exception
  helper_method :subdomain, :current_company
  before_filter :validate_subdomain, :authenticate_user!

private # ----------------------------------------------------

	def current_company
	    # The where clause is assuming you are using Mongoid, change appropriately
	    # for ActiveRecord or a different supported ORM.
	    @current_company ||= Company.where(slug: subdomain).first
	end

	def subdomain
	  request.subdomain
	end

	# This will redirect the user to your 404 page if the account can not be found
	# based on the subdomain.  You can change this to whatever best fits your
	# application.
	def validate_subdomain
	    redirect_to '/404.html' if current_company.nil?
	end

end
