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
		redirect_to "/" and return if (params[:email].blank? || params[:company].blank?)
		Pilot.create(email: params[:email], company: params[:company])

		if params[:page] == "construction"
			list_id = "4a4ecf64f7"
		elsif params[:page] == "hospitality"
			list_id = "92e6dc95ff"
		else
			list_id = "49771b3c4f"
		end

		$mailchimp.lists.subscribe(list_id, {email: params[:email]}, nil, double_optin=false)
	rescue
	end

	def faq
	end

	def campaigns
	end

	def construction
		respond_to do |format|
      		format.html          # /app/views/home/index.html.erb
      		format.html.mobile    # /app/views/home/index.html+phone.erb
		end
	end 


	def events
	end

	def hospitality
		respond_to do |format|
      		format.html          # /app/views/home/index.html.erb
      		format.html.mobile    # /app/views/home/index.html+phone.erb
		end
	end

	def retail
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
