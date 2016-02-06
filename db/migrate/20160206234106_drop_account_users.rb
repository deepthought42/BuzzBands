class DropAccountUsers < ActiveRecord::Migration
  def change
    drop_table :account_users
  end
end
