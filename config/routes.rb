SRC::Application.routes.draw do
  get 'contact' => 'welcome#contact', as: :contact
  get 'about' => 'welcome#about', as: :about

  resources :members, only: [:index] do
    collection do
      get :officers
    end
  end
  root 'welcome#home'

  constraints Clearance::Constraints::SignedIn.new do
    resources :members, only: [] do
      collection do
        get :non_competitive
        get :competitive
      end
    end
    resources :practices, only: [:index]
    get 'log_a_run' => 'welcome#log_a_run', as: :log_a_run
    get 'spartanlink' => 'welcome#spartan_link', as: :spartan_link
    get 'members/:id/password' => 'passwords#change', :as => :member_password
    put 'members/:id/password' => 'passwords#user_edit'
    get 'members/:id/password/change' => 'passwords#change', :as => :change_user_password
  end

  constraints Clearance::Constraints::SignedIn.new { |user| user.officer } do
    get '/admin' => 'admin#panel', as: :admin_panel
    resources :members do
      collection do
        get :edit, action: :edit_members
      end
    end
    resources :routes do
      collection do
        get :edit, action: :edit_routes
      end
    end
    resources :carousel_items, except: [:show] do
      collection do
        get :edit, action: :edit_all
        put :reorder
      end
    end
    resources :events do
      collection do
        get :edit, action: :edit_events
      end
    end
    resources :practices, except: [:update] do
      collection do
        get :edit, action: :admin_edit
      end
    end
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
