class CreateAccountVenues < ActiveRecord::Migration
  def change
    create_table :account_venues do |t|
      t.belongs_to :venue, index: true
      t.belongs_to :account, index: true
      t.timestamps null: false
    end
  end
end
