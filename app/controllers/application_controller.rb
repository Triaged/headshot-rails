class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include UrlHelper
  protect_from_forgery with: :exception
  helper_method :subdomain, :current_company, :is_admin?
  before_filter :authenticate_user!, :validate_subdomain

  def after_sign_in_path_for(resource)
    if resource.is_a? Admin
    	admin_companies_url(subdomain: 'admin')
    elsif resource.admin?
    	manage_users_url(subdomain: resource.company.slug)
    else
    	download_url(subdomain: resource.company.slug)
    end
	end

	def redirect_to(options = {}, response_status_and_flash = {})
    if success = response_status_and_flash.delete(:success)
      flash[:success] = success
    end

    if secondary = response_status_and_flash.delete(:secondary)
      flash[:secondary] = secondary
    end

    super(options, response_status_and_flash)
  end  

private # ----------------------------------------------------

	def current_company
	    @current_company ||= Company.where(slug: subdomain).first
	end

	def is_admin?
		current_user.admin?
	end

	def subdomain
	  request.subdomain
	end

	# This will redirect the user to your 404 page if the account can not be found
	# based on the subdomain.  You can change this to whatever best fits your
	# application.
	def validate_subdomain
	    redirect_to '/404.html' if (current_company.nil? || current_user.company != current_company)
	end

end
