class TagSetSerializer < ActiveModel::Serializer
  attributes :id, :name, :priority

  has_many :tag_set_items
end
