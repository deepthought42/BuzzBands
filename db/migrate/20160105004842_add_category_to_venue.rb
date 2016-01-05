class AddCategoryToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :category, :string
  end
end
