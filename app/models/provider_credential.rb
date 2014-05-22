class ProviderCredential < ActiveRecord::Base
  belongs_to :user
  belongs_to :provider
  belongs_to :company
end
