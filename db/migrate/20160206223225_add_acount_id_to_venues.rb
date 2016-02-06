class AddAcountIdToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :account_id, :integer
  end
end
