class UserTagSetItems < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag_set_item
end
