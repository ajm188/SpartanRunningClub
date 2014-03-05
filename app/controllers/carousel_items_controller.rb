class CarouselItemsController < ApplicationController
	before_action :set_carousel_item, only: [:edit, :update, :destroy]

	def new
		@carousel_item = CarouselItem.new
	end

	def create
		@carousel_item = CarouselItem.new carousel_item_params
		@carousel_item.place = CarouselItem.count
		if @carousel_item.save
			redirect_to edit_carousel_path
		else
			render action: 'new'
		end
	end

	def edit_carousel
		@items = CarouselItem.in_order
	end

	def edit
	end

	def destroy
		location = @carousel_item.place
		items = CarouselItem.where('place > ?', location)
		items.each do |item|
			item.place -= 1
			item.save
		end
		@carousel_item.destroy
		redirect_to edit_carousel_path
	end

	def reorder
		@items = CarouselItem.in_order
	end

	def submit_new_order
		item1, item2 = CarouselItem.find(params[:item1_id]), CarouselItem.find(params[:item2_id])
		swap_places item1, item2
		item1.save
		item2.save
		redirect_to reorder_carousel_path
	end

	private
		def set_carousel_item
			@carousel_item = CarouselItem.find params[:id] if params[:id]
		end

		def carousel_item_params
			params.require(:carousel_item).permit(:primary_caption, :secondary_caption, :image)
		end

		def swap_places item1, item2
			temp = item1.place
			item1.place = item2.place
			item2.place = temp
		end
end
