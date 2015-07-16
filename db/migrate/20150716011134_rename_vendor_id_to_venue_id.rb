class RenameVendorIdToVenueId < ActiveRecord::Migration
  def change
    rename_column :promotions, :vendor_id, :venue_id
  end
end
