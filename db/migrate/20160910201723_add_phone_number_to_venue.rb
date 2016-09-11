class AddPhoneNumberToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :phone, :string, :limit => 10
  end
end
