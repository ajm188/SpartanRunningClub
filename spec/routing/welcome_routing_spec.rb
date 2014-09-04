require 'rails_helper'

RSpec.describe WelcomeController, type: :routing do
  describe 'routing' do
    it 'routes to #home' do
      expect(get: '/').to route_to 'welcome#home'
    end

    it 'routes to #about' do
      expect(get: '/about').to route_to 'welcome#about'
    end

    it 'routes to #contact' do
      expect(get: '/contact').to route_to 'welcome#contact'
    end

    it 'routes to #spartan_link' do
      expect(get: '/spartanlink').to route_to 'welcome#spartan_link'
    end
  end
end
