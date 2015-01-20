class AddLocationToPractices < ActiveRecord::Migration
  def up
    add_column :practices, :location, :string
  end

  def down
    remove_column :practices, :location
  end
end
