class RenameCarouselItemsIndexToPlace < ActiveRecord::Migration
  def change
  	rename_column :carousel_items, :index, :place
  end
end
