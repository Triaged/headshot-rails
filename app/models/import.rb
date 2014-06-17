class Import < ActiveRecord::Base
	has_many :imported_users, dependent: :destroy
	accepts_nested_attributes_for :imported_users
end
