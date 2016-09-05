class AddPhotoUrlToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :logo_url, :text
  end
end
