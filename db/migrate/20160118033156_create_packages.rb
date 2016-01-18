class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name, null: false
      t.integer :venue_count, null: false
      t.integer :promotion_count, null: false
      t.decimal :band_fee, null: false
      t.decimal :price, null: false
      t.timestamps null: false
    end
  end
end
