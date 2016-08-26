class AddDescriptionAndNotesToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :notes, :text
  end
end
