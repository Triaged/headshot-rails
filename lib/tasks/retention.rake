namespace :retention do
  desc "TODO"
  

  task :first, [:deliver] => :environment do |t, args|
  	users = User.where("DATE(confirmation_sent_at) = ?", Date.today-1).where(confirmed_at: nil).where.not(admin: true)
  	users.each do |user|
  		puts user.email
  		RetentionMailer.new(user.id).deliver if args[:deliver]
  	end
  end

  

end