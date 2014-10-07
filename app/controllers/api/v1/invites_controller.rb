class API::V1::InvitesController < APIController

	#skip_before_filter :authenticate_user_from_token!
	#skip_before_filter :authenticate_user!
	#before_filter :authenticate_user_from_token!, :except => [:create]
	#before_filter :authenticate_user!, :except => [:create]
	#skip_before_filter :current_company
	skip_before_filter :verify_authenticity_token

	before_filter :log_invites

	def index
		logger.debug('INVITES INDEX!');
		render :json => { "message" => "ok" }, :status => 200
	end

	# Handles post to /invites: request from user to send invites
	def create
		invites = invites_params['invites']
		current_user.invites.create( invites )
		InviteService.new(invites).deliver
		render :json => { "message" => "ok" }, :status => 200
	end

	def show
		logger.debug('INVITES SHOW!');
		render :json => { "message" => "ok" }, :status => 200
	end

	def log_invites
		logger.debug( request.headers )
		logger.debug( request.original_url )
		logger.debug( params )
		#log_headers
	end

	def log_headers
		headers = {}
		self.request.env.each do |header|
			headers[ header[0] ] = header[1]
		end
		headers.keys.sort.each do |key|
			puts "#{key}, #{headers[key]}"
		end
	end

	def invites_params
		params.permit( invites: [ :email, :phone ] )
	end

end
