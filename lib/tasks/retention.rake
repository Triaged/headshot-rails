namespace :retention do
  desc "TODO"
  

  task first: :environment do
  	users = User.where("DATE(created_at) = ?", Date.today-1).where(confirmed_at: nil)
  	users.each do |user|
  		puts user.email
  	end
  end

  

end