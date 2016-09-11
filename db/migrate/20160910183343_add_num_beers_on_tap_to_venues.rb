class AddNumBeersOnTapToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :num_beers_on_tap, :integer
  end
end
