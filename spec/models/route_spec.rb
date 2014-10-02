require 'rails_helper'

RSpec.describe Route, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :distance }
  it { should validate_presence_of :map_my_run_id }

  it { should validate_numericality_of(:distance).is_greater_than(0) }

  describe '#embedded_map_url' do
    before(:all) do
      @route = Route.new({map_my_run_id: '1234'})
    end

    it 'should return the cdn url' do
      expect(@route.embedded_map_url).to eq "http://snippets.mapmycdn.com/routes/view/embedded/1234?width=600&height=400&&line_color=E60f0bdb&rgbhex=DB0B0E&distance_markers=0&unit_type=imperial&map_mode=ROADMAP"
    end
  end
end
