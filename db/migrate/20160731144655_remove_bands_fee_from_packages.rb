class RemoveBandsFeeFromPackages < ActiveRecord::Migration
  def change
    remove_column :packages, :band_fee
  end
end
