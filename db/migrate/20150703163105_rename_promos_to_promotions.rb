class RenamePromosToPromotions < ActiveRecord::Migration
  def change
    rename_table :promos, :promotions
  end
end
