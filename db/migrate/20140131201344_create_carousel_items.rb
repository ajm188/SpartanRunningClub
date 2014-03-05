class CreateCarouselItems < ActiveRecord::Migration
  def change
    create_table :carousel_items do |t|
      t.string :primary_caption
      t.string :secondary_caption
      t.integer :index
      
      t.timestamps
    end
  end
end
