class AddRatingToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :rating, :decimal
  end
end
