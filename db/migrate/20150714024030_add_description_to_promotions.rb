class AddDescriptionToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :description, :string
  end
end
