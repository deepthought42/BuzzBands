class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :venue_id, null: false
      t.string :user_id, null: false
      t.string :band_count, null: false
      t.string :price, null: false
      t.string :status, null: false
      t.string :color, null: false
      t.timestamps null: false
    end
  end
end
