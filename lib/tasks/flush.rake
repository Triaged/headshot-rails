namespace :flush do
  desc "TODO"
  

  task all: :environment do
  	User.destroy_all
    Company.destroy_all
    ProviderCredential.destroy_all
    Rails.logger.info "flushed"
  end

  

end