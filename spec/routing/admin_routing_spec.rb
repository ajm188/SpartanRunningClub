require 'rails_helper'

RSpec.describe AdminController, type: :routing do
  describe 'routing' do
    it 'routes to #panel' do
      expect(get: '/admin').to route_to 'admin#panel'
    end
  end
end
