class AddCapacityFieldToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :capacity, :integer
  end
end
