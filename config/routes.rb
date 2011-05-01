Anmeldung::Application.routes.draw do
  match ':locale/users/create' => 'users#create', :as => :create
  match ':locale/' => 'users#index', :as => :index
  
  root :to => "users#index"
  
  # Catch-all to get those users who have weird start pages so they don't get
  # a 404 when first connecting to our net
  match '*path', :to => 'users#index'
end
