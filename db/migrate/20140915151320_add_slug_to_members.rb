class AddSlugToMembers < ActiveRecord::Migration
  def up
    add_column :members, :slug, :string, unique: true
  end

  def down
    remove_column :members, :slug
  end
end
