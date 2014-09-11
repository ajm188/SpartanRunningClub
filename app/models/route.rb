class Route < ActiveRecord::Base
  has_attached_file :map_image,
    styles: { thumbnail: '200x75#', show: '1000x500#' }
  validates_attachment_presence :map_image
  validates_attachment_content_type :map_image,
    content_type: /\Aimage/

  validates :title, :distance,
    presence: true, allow_blank: false
  validates :distance,
    numericality: { greater_than: 0 }
end
