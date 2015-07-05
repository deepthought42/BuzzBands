class CreateVenueTable < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state, limit: 2
      t.string :zip_code, limit: 5
      t.timestamps null: false
    end
  end
end
