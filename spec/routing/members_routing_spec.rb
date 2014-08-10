require 'rails_helper'

RSpec.describe MembersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/members').to route_to 'members#index'
    end

    it 'routes to #new' do
      expect(get: '/members/new').to route_to 'members#new'
    end

    it 'routes to #show' do
      expect(get: '/members/1').to route_to('members#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/members/1/edit').to route_to('members#edit', id: '1')
    end

    it 'routes to #competitive' do
      expect(get: '/members/competitive').to route_to 'members#competitive'
    end

    it 'routes to #edit_all' do
      expect(get: '/members/edit').to route_to 'members#edit_all'
    end

    it 'routes to #non_competitive' do
      expect(get: '/members/non_competitive').to route_to 'members#non_competitive'
    end

    it 'routes to #officers' do
      expect(get: '/members/officers').to route_to 'members#officers'
    end

    it 'routes to #create' do
      expect(post: '/members').to route_to 'members#create'
    end

    it 'routes to #update' do
      expect(put: '/members/1').to route_to('members#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/members/1').to route_to('members#destroy', id: '1')
    end
  end
end
