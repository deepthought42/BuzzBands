class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.belongs_to :venue, index: true
      t.string  :uuid
      t.timestamps null: false
    end
  end
end
