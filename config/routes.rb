# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {sessions: "users/sessions"}
  resources :users do
    collection do
      get :edit_password
      post :change_password
      get :edit_profile
      put :update_profile
    end
  end
  resources :roles
  resources :customers
  resources :products do
    member do
      get 'qrcode_url'
    end
  end
  resources :boxes do
    member do
      delete 'user_box_archive'
      delete 'product_box_archive'
      post 'create_user_box'
      post 'create_product_box'
      get 'fetch_box'
      get 'qrcode_url'
      get 'box_adjustment'
    end
    collection do
      get :search_product_box
      get :product_boxes_threshold
    end
  end
  resources :replenishments, only: [:new, :create, :index, :show] do
    collection do
      get :logbook
    end
  end
  resources :adjustments, only: [:index, :create]
  resources :incidents, only: [:new, :create, :index]
  resources :settings, only: [:index]
  post 'settings', to: 'settings#update'
  get 'home/index'
  get 'dashboard', to: 'dashboard#index'
  get 'reports', to:  "reports#index"
  get 'reports/medicine_report', to:  "reports#medicine_report"
  get 'states', to:  "home#states"
  get 'cities', to:  "home#cities"
  get 'customer_users', to:  "home#users_by_customer"
  get 'customer_boxes', to:  "home#boxes_by_customer"
  get 'box_location', to:  "home#location_by_box"
  get 'user_boxes', to:  "home#boxes_by_user"
  get 'box_products', to:  "home#products_by_box"
  get 'consumed_products_by_box', to: "dashboard#consumed_products_by_box"
  get 'consumed_products_by_duration', to: "dashboard#consumed_products_by_duration"
  get 'consumed_products_boxes_by_duration', to: "dashboard#consumed_products_boxes_by_duration"
  get 'incidents_by_boxes', to: "dashboard#incidents_by_boxes"
  get 'boxes_in_red_zone', to: "dashboard#boxes_in_red_zone"
  get 'user_notifications', to: "users#user_notifications"
  post 'mark_notification_as_read', to: "users#mark_notification_as_read"
  post 'uploadfiles'=>'replenishments#uploadfiles'
  delete 'removefiles'=>'replenishments#removefiles'
  root to: 'home#index'

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      post 'auth/login', to: 'users#login'
      post 'auth/change_password', to: 'users#change_password'
      post '/upload_incident_image', to: 'incident_requests#upload_incident_image'
      put 'update_profile', to: 'users#update_profile'
      post '/forget_password', to: 'users#forget_password'
      post '/update_player_id', to: 'users#update_player_id'
      post '/support', to: 'supports#support'
      post '/settings', to: 'settings#update'
      get '/settings', to: 'settings#index'
      resources :boxes, only: [:index]
      resources :notifications, only: [:index]
      resources :incidents, only: [:create, :index]
    end
  end

  get 'customers/roles/:id', to: "customers#roles"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
end
