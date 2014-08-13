SRC::Application.routes.draw do
  # Welcome routes
  root 'welcome#home'
  get 'about' => 'welcome#about', as: :about
  get 'contact' => 'welcome#contact', as: :contact
  get 'log_a_run' => 'welcome#log_a_run', as: :log_a_run
  get 'spartanlink' => 'welcome#spartan_link', as: :spartan_link

  # Password resetting routes
  get 'members/:id/password' => 'passwords#change', :as => :member_password
  put 'members/:id/password' => 'passwords#user_edit'
  get 'members/:id/password/change' => 'passwords#change', :as => :change_user_password

  # Admin routes
  get 'admin' => 'admin#panel', as: :admin_panel

  # Regular resource routes
  resources :carousel_items, except: [:index, :show] do
    collection do
      get :edit, action: :edit_all
      put :reorder
    end
  end

  resources :events do
    collection do
      get :edit, action: :edit_all
    end
  end

  resources :followings, only: [:create, :destroy]

  resources :meetings

  resources :members do
    collection do
      get :competitive
      get :edit, action: :edit_all
      get :non_competitive
      get :officers
    end
  end

  resources :practices, except: [:show, :edit, :update] do
    collection do
      get :edit, action: :edit_all
    end
  end

  resources :routes do
    collection do
      get :edit, action: :edit_all
    end
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
