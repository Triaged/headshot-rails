class HomeController < ApplicationController
	skip_before_filter :authenticate_user!
	before_action :check_redirect
	
	layout "home"

	def index
		respond_to do |format|
      format.html          # /app/views/home/index.html.erb
      format.html.mobile    # /app/views/home/index.html+phone.erb
    end
	end

	def about
	end

	def signup
		Pilot.create(email: params[:email], company: params[:company])
		$mailchimp.lists.subscribe("49771b3c4f", {email: params[:email]}, double_optin=false)
	end

	def faq
	end

private
	
	def check_redirect
		if user_signed_in?
			if is_admin?
				redirect_to manage_users_url(subdomain: current_user.company.slug) and return
			else
				redirect_to download_url(subdomain: current_user.company.slug) and return
			end
		end
	end

end
