class AddNameToEvent < ActiveRecord::Migration
  def change
    add_column :events, :name, :string
    add_column :venues, :address, :string
  end
end
