class CreateAccountUsers < ActiveRecord::Migration
  def change
    create_table :account_users do |t|
      t.belongs_to :account, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.integer :role
      t.timestamps null: false
    end
  end
end
