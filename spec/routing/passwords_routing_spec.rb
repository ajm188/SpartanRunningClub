require 'rails_helper'

RSpec.describe PasswordsController, type: :routing do
  describe 'routing' do
    it 'routes to #change' do
      expect(get: '/members/1/password').to route_to('passwords#change', id: '1')
    end

    it 'routes to #change' do
      expect(get: '/members/1/password/change').to route_to('passwords#change', id: '1')
    end

    it 'routes to #user_edit' do
      expect(put: '/members/1/password').to route_to('passwords#user_edit', id: '1')
    end
  end
end
