class AddLongLatToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :longitude, :float
    add_column :venues, :latitude, :float
  end
end
