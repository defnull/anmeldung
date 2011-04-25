Anmeldung::Application.routes.draw do
  
  match ':locale/users/condition' => 'users#condition', :as => :condition
  match ':locale/users/create' => 'users#create', :as => :create
  match ':locale/users/conflict' => 'users#conflict', :as => :conflict
  match ':locale/users/login' => 'users#login', :as => :login
  match ':locale/users/forgotten' => 'users#forgotten', :as => :forgotten
  match ':locale/hosts/create' => 'hosts#create', :as => :create_host
  match ':locale/users/confirm' => 'users#confirm', :as => :confirm
  match ':locale/' => 'users#index', :as => :index
  
  root :to => "users#index"
  
  # Catch-all to get those users who have weird start pages so they don't get
  # a 404 when first connecting to our net
  match '*path', :to => 'users#index'
end
