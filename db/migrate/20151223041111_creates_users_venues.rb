class CreatesUsersVenues < ActiveRecord::Migration
  def change
    create_table :users_venues do |t|
      t.belongs_to :venue, index: true
      t.belongs_to :user, index: true
      t.integer :role
      t.timestamps null: false
    end
  end
end
