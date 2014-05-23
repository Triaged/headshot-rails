class AccountSerializer < ActiveModel::Serializer
  attributes :id

  has_one :current_user, serializer: UserSerializer

  def current_user
    object
  end


end
