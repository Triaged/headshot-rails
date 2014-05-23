class AccountSerializer < ActiveModel::Serializer
  attributes :id

  has_one :current_user, serializer: UserSerializer


end
