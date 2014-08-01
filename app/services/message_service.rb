class MessageService

	def initialize user_id, thread_id, message_params
		@user = User.find(user_id)
		@thread_id = thread_id
		@message = Hashie::Mash.new(message_params)
	end

	def deliver 
		author = User.find(@message.author_id)

		if @user.can_receive_push?
			PushService.new(@user.id).deliver_message author, message.body, @thread_id
		else
			MessageMailer.mobile_message(@user.id, author.id, @message.body).deliver
		end
	end
		

end