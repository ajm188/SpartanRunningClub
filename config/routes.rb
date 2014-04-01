SRC::Application.routes.draw do
  get "/contact" => 'welcome#contact', as: :contact
  get "/about" => 'welcome#about', as: :about
  resources :members, only: [:index]
  get '/members/officers' => 'members#officers', as: :officers
  root 'welcome#home'

  constraints Clearance::Constraints::SignedIn.new do
    get '/members/competitive' => 'members#competitive', as: :competitive_members
    get '/members/non_competitive' => 'members#non_competitive', as: :non_competitive_members
    resources :practices, only: [:index]
    get '/log_a_run' => 'welcome#log_a_run', as: :log_a_run
    get '/practice_schedule' => 'welcome#practice_schedule', as: :practice_schedule
    get '/spartanlink' => 'welcome#spartan_link', as: :spartan_link
  end

  constraints Clearance::Constraints::SignedIn.new { |user| user.officer } do
    get '/admin' => 'admin#panel', as: :admin_panel
    get '/carousel/edit' => 'carousel_items#edit_carousel', as: :edit_carousel
    get '/carousel/reorder' => 'carousel_items#reorder', as: :reorder_carousel
    patch '/carousel/reorder/:item1_id&:item2_id' => 'carousel_items#submit_new_order', as: :submit_carousel_order
    get '/routes/edit' => 'routes#edit_routes', as: :edit_routes
    get '/members/edit' => 'members#edit_members', as: :edit_members
    get '/events/edit' => 'events#edit_events', as: :edit_events
    resources :members, :routes, :carousel_items, :events
    get '/practices/edit' => 'practices#admin_edit', as: :practice_edit
    resources :practices, only: [:index, :edit, :destroy, :new, :create]
  end

  constraints Clearance::Constraints::SignedIn.new do
    resources :members, only: [:index, :show, :edit]
    resources :routes, :events, only: [:index, :show]
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
