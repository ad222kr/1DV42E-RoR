class DropTableVenues < ActiveRecord::Migration
  def change
    drop_table :venues do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
