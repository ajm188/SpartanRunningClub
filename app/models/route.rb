class Route < ActiveRecord::Base
  validates :title, :distance, :map_my_run_id,
    presence: true, allow_blank: false
  validates :distance,
    numericality: { greater_than: 0 }

  # Return the url to embed a map for this route in an iframe
  def embedded_map_url
    "http://snippets.mapmycdn.com/routes/view/embedded/#{map_my_run_id}?width=600&height=400&&line_color=E60f0bdb&rgbhex=DB0B0E&distance_markers=0&unit_type=imperial&map_mode=ROADMAP"
  end
end
