ESmart::Application.routes.draw do



  devise_for :users

  resources :orders
  resources :line_items
  resources :carts
  resources :users
  resources :categories
  resources :products
  resources :products
  resources :roles
  resources :role_users


  get "shipping_returns/index"
  get "contact/index"
  get "home/index"
  get "about/index"
  get "shipping_returns/index"
  get "usermanagement" => "usermanagement#index", :as => "usermanagement"
  get "dashboard" => "dashboard#index", :as => "dashboard"


  match '/products' => 'products#index'
  match '/about' => 'about#index'
  match '/contact' => 'contact#index'
  match 'home' => 'home#index'
  match 'shipping' => 'shipping_returns#index'

  #Handling devise routes
  devise_for :users, :controllers => {:sessions => 'devise/sessions', :registrations => 'devise/registrations', :passwords => 'devise/passwords'}, :skip => [:sessions] do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  ############
  #Search Bar#
  ############
  post '/search' => 'home#search', :as => 'search'

   root :to => 'home#index'
end
