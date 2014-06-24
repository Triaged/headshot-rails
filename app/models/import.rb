class Import < ActiveRecord::Base

	belongs_to :provider
	has_many :imported_users, dependent: :destroy
	accepts_nested_attributes_for :imported_users
end
