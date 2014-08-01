class AccountSerializer < ApplicationSerializer
  attributes :id, :installed_app, :authentication_token, :company_id, :company_name

  has_one :current_user, serializer: UserSerializer

  def current_user
    object
  end

  def installed_app
    object.installed_app?
  end

  def company_name
  	object.company.name
  end


end
