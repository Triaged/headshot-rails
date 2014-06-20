class UserSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :full_name, :avatar_face_url, :avatar_url, :email
  
  has_one :employee_info, :department
  has_one :primary_office_location
  has_one :current_office_location
  

  def avatar_url
  	object.avatar.url
  end

  def avatar_face_url
  	object.avatar.face.url
  end
end
