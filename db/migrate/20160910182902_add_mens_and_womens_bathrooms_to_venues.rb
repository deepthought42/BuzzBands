class AddMensAndWomensBathroomsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :mensBathroom, :integer
    add_column :venues, :womensBathroom, :integer
  end
end
