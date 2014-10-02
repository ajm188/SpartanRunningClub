class RemoveImagesFromRoutes < ActiveRecord::Migration
  def up
    remove_attachment :routes, :map_image
  end

  def down
    add_attachment :routes, :map_image
  end
end
