class ChangePromoterToUserForPromotions < ActiveRecord::Migration
  def change
    rename_column :promotions, :promoter_id, :vendor_id
  end
end
