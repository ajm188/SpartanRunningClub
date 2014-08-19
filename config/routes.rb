SRC::Application.routes.draw do
  # Welcome routes
  root 'welcome#home'
  get 'about' => 'welcome#about', as: :about
  get 'contact' => 'welcome#contact', as: :contact
  get 'log_a_run' => 'welcome#log_a_run', as: :log_a_run
  get 'spartanlink' => 'welcome#spartan_link', as: :spartan_link

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

    member do
      get :password, controller: 'passwords', action: :change
      put :password, controller: 'passwords', action: :user_edit
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
end
