class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name

      t.timestamps null: false
    end
    
    add_reference :events, :venue, index: true
    add_foreign_key :events, :venues
    
    
    
  end
end
