class Route < ActiveRecord::Base
	has_attached_file :map_image, styles: { thumbnail: '200x75#' }
end
