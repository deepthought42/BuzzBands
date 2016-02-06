class DropAccountVenues < ActiveRecord::Migration
  def change
    drop_table :account_venues
  end
end
