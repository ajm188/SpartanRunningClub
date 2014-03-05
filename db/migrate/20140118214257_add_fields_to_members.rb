class AddFieldsToMembers < ActiveRecord::Migration
  def change
  	add_column :members, :first_name, :string
  	add_column :members, :last_name, :string
  	add_column :members, :case_id, :string, limit: 6
  	add_column :members, :year, :string
  	add_column :members, :competitive, :boolean
  	add_column :members, :officer, :boolean
  	add_column :members, :position, :string
  end
end
