class DropPromotersTable < ActiveRecord::Migration
  def change
    drop_table :promoters
  end
end
