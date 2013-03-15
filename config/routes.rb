ESmart::Application.routes.draw do
  devise_for :users
=begin
  resource routes allow you to quickly declare all common routes of a particular controller.
=end

  resources :orders
  resources :line_items
  resources :carts
  resources :users
  resources :categories
  resources :products do
    resource :reviews
  end
  resources :roles
  resources :reviews
  resources :role_users
  resources :contacts,
            :controller => 'contact_us/contacts',
            :only       => [:new, :create]
  match 'contact-us' => 'contact_us/contacts#new', :as => :contact_us


  get "shipping_returns/index"
  get "payment/index"
  get "home/index"
  get "about/index"
  get "shipping_returns/index"
  get "usermanagement" => "usermanagement#index", :as => "usermanagement"
  get "dashboard" => "dashboard#index", :as => "dashboard"
  get "payment" => "payments#index", :as => "payment"

  match '/products' => 'products#index'
  match '/about' => 'about#index'
  match '/payment' => 'payments#index'
  match 'home' => 'home#index'
  match 'shipping' => 'shipping_returns#index'



  #Handling devise routes
  devise_for :users, :controllers => {:sessions => 'devise/sessions', :registrations => 'devise/registrations', :passwords => 'devise/passwords'}, :skip => [:sessions] do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    get '/register' => 'devise/registrations#new', :as => :registrations
    post '/login' => 'devise/sessions#create', :as => :user_session
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  ############
  #Search Bar#
  ############
  post '/search' => 'home#search', :as => 'search'

  #As mentioned in the dashboard and home controller the routes are set here to enable the search to work. Here
  #a post method is being used so that when a user searches for a product it posts the request and then fetches it by
  #returning the @result which is found in either controllers

   root :to => 'home#index' #Root of the application
end
