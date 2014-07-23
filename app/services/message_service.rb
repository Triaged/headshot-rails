class MessageService

	def initialize user_id, message_params
		@user = User.find(user_id)
		@message = Hashie::Mash.new(message_params)
	end

	def deliver 
		author = User.find(@message.author_id)

		if @user.installed_app?
			PushService.new(@user.id).deliver("#{author.first_name.capitalize}: #{@message.body}".truncate(150), increase_badge_count=true)
		else
			MessageMailer.mobile_message(@user.id, author.id, @message.body).deliver
		end
	end
		

end