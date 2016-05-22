class CreateVenuesAgain < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
    end
    
    add_foreign_key :events, :venues
    
  end
end
