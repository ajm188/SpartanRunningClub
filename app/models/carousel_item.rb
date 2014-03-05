class CarouselItem < ActiveRecord::Base
	has_attached_file :image, styles: { carousel: '1000x500#', thumbnail: '200x75#' }

	scope :first_index, -> { where(place: 0).first }
	scope :rest, -> { where("place!=  0") }
	scope :in_order, -> { order(:place) }


	def self.save_all
		all.each { |item| item.save }
	end
end
