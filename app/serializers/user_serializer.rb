class UserSerializer < ApplicationSerializer
  # cached
  # delegate :cache_key, to: :object

  attributes :id, :first_name, :last_name, :full_name, :avatar_face_url, :avatar_url, :email, :manager_id
  attributes :primary_office_location_id, :current_office_location_id, :department_id, :installed_app

  has_one :employee_info
  
  
  def manager_id
    object.manager_id.to_s
  end

  def department_id
    object.department_id.to_s
  end

  def current_office_location_id
    object.current_office_location_id.to_s
  end

  def primary_office_location_id
    object.primary_office_location_id.to_s
  end

  def avatar_url
  	object.avatar.url
  end

  def avatar_face_url
  	object.avatar.face.url
  end

  def installed_app
    object.installed_app?
  end
  
end
