class RemoveResourceIdAndResourceTypeFromRoles < ActiveRecord::Migration
  def change
    remove_column :roles, :resource_id, :integer
    remove_column :roles, :resource_type, :string
  end
end
