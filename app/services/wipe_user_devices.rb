class WipeUserDevices

	def initialize user_id
		@user = User.find(user_id)
	end

	def wipe!
		PushService.new(@user.id).deliver(nil, false, { "WIPE_DEVICE" => true })
	end
end