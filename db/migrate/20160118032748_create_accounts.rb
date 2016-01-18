class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id, null: false
      t.integer :package_id, null: false
      t.timestamps null: false
    end
  end
end
