class ChangeRolesFromIntegerToString < ActiveRecord::Migration
  def change
    change_column :users, :role, :text
  end
end
