class TagSetSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :tag_set_items
end
