class AddPromoterIdToPromo < ActiveRecord::Migration
  def change
    add_column :promos, :promoter_id, :integer
  end
end
