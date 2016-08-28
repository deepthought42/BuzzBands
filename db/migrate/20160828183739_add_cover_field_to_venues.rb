class AddCoverFieldToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :cover, :integer
  end
end
