class UserSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :name, :avatar_face_url, :avatar_url, :email
  
  has_one :employee_info
  has_one :manager, embed: :ids
  has_many :subordinates, embed: :ids

  def avatar_url
  	object.avatar.url
  end

  def avatar_face_url
  	object.avatar.face.url
  end
end
