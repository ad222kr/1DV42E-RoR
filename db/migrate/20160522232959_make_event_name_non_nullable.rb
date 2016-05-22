class MakeEventNameNonNullable < ActiveRecord::Migration
  def change
    change_column_null :events, :name, false
  end
end
