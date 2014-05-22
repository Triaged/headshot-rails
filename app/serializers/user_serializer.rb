class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :name, :avatar_face_url, :avatar_url
  attributes :cell_phone, :office_phone, :email
  attributes :job_title, :job_start_date, :birth_date

  has_one :employee_info

  def avatar_url
  	object.avatar.url
  end

  def avatar_face_url
  	object.avatar.face.url
  end
end
