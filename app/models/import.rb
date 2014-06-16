class Import < ActiveRecord::Base
	has_many :imported_users, dependent: :destroy
end
