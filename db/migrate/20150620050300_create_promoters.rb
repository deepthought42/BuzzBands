class Promoters < ActiveRecord::Migration
  def change
    create_table :promoters do |t|
      t.string :name
      t.timestamps
    end
  end
end
