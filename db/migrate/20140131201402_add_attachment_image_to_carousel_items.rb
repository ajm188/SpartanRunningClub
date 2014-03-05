class AddAttachmentImageToCarouselItems < ActiveRecord::Migration
  def self.up
    change_table :carousel_items do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :carousel_items, :image
  end
end
