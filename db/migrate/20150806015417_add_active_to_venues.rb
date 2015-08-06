class AddActiveToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :active, :boolean
  end
end
