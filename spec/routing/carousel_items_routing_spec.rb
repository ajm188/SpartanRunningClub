require 'rails_helper'

RSpec.describe CarouselItemsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/carousel_items').to route_to 'carousel_items#index'
    end

    it 'routes to #new' do
      expect(get: '/carousel_items/new').to route_to 'carousel_items#new'
    end

    it 'routes to #edit' do
      expect(get: '/carousel_items/1/edit').to route_to('carousel_items#edit', id: '1')
    end

    it 'routes to #edit_all' do
      expect(get: '/carousel_items/edit').to route_to 'carousel_items#edit_all'
    end

    it 'routes to #create' do
      expect(post: '/carousel_items').to route_to 'carousel_items#create'
    end

    it 'routes to #update' do
      expect(put: '/carousel_items/1').to route_to('carousel_items#update', id: '1')
    end

    it 'routes to #reorder' do
      expect(put: '/carousel_items/reorder').to route_to 'carousel_items#reorder'
    end

    it 'routes to #destroy' do
      expect(delete: '/carousel_items/1').to route_to('carousel_items#destroy', id: '1')
    end
  end
end
