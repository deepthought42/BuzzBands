class AddIsActiveToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :active, :boolean
  end
end
