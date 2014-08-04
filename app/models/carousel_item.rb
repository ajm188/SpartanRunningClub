class CarouselItem < ActiveRecord::Base
	has_attached_file :image, styles: { carousel: '1000x500#', thumbnail: '200x75#' }

  default_scope -> { order(:place) }

	scope :first_index, -> { where(place: 0).first }
	scope :rest, -> { where("place != 0") }

  validates :place,
    presence: true, allow_blank: false
  validates :place,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates_attachment_presence :image
end
