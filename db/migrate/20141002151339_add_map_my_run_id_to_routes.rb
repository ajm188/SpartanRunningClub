class AddMapMyRunIdToRoutes < ActiveRecord::Migration
  def up
    add_column :routes, :map_my_run_id, :string
  end

  def down
    remove_column :routes, :map_my_run_id
  end
end
