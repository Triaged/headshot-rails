class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :name, :avatar_face_url, :avatar_url
  attributes :cell_phone, :office_phone, :email
  attributes :job_title, :job_start_date, :birth_date

  def job_title
  	object.employee_info.job_title if object.employee_info
  end

  def job_start_date
  	object.employee_info.job_start_date if object.employee_info
  end

  def birth_date
  	object.employee_info.birth_date if object.employee_info
  end

  def cell_phone
  	object.employee_info.cell_phone if object.employee_info
  end

  def office_phone
  	object.employee_info.office_phone if object.employee_info
  end

  def avatar_url
  	object.avatar.url
  end

  def avatar_face_url
  	object.avatar.face.url
  end
end
