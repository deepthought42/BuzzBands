class AddActiveFlagToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :active, :boolean
  end
end