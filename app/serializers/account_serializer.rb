class AccountSerializer < ApplicationSerializer
  attributes :id, :installed_app, :authentication_token

  has_one :current_user, serializer: UserSerializer

  def current_user
    object
  end


end
