class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :service, :application_id, :token
end
