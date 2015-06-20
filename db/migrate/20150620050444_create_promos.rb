class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :name
      t.string :ad_location
      t.timestamp :start_time
      t.timestamp :end_time
      
      t.timestamps
    end
  end
end
