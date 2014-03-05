class AddAttachmentMapImageToRoutes < ActiveRecord::Migration
  def self.up
    change_table :routes do |t|
      t.attachment :map_image
    end
  end

  def self.down
    drop_attached_file :routes, :map_image
  end
end
