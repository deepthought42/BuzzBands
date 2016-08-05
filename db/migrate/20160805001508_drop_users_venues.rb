class DropUsersVenues < ActiveRecord::Migration
  def change
    drop_table :users_venues
  end
end
