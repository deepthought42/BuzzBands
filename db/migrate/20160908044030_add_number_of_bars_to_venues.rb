class AddNumberOfBarsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :num_bars, :integer
  end
end
