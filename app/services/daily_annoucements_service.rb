class DailyAnnouncementsService

	def announce_birthdays
		Company.all.each do |company|
			birthday_users = company.users.birth_date_today
			accounce_birthdays_for_company company, birthday_users
		end
	end

	def accounce_birthdays_for_company company, birthday_users
		birthday_users.each do |birthday_user|
			company.users.each do |user|
				deliver_birthday_announcement user, birthday_user
			end
		end
	end

	def deliver_birthday_announcement user, birthday_user
		PushService.new(user.id).deliver("It's #{birthday_user.first_name}'s special day, say Happy Birthday!")
	end

	def announce_anniversaries
		Company.all.each do |company|
			users = company.users.job_start_date_today
		end
	end

end