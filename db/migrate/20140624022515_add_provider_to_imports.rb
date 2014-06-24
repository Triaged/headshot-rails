class AddProviderToImports < ActiveRecord::Migration
  def change
    add_reference :imports, :provider, index: true
  end
end
