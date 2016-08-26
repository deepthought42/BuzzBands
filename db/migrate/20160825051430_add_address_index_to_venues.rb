class AddAddressIndexToVenues < ActiveRecord::Migration
  def change
    add_index :venues, [:address], :unique => true
  end
end
