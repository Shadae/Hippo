Hippo::Application.routes.draw do
  get "orders/new"
  get "orders/index"
  get "welcome/index"
  resources :users
  resources :products do 
    resources :category_products
    resources :reviews, only: [:new, :create, :index]
  end
#This section is probably duplicating things stuff might break, fix this
  # get '/products'    => "products#index"
  get 'products/:id' => "products#show"

  # get '/products/new' => "products#new"
  get '/products/:id/edit' => "products#edit"
  # get '/products/create' => "products#create"
  # get '/products/destroy' => "products#destroy"
  # get '/products/put' => "products#update"
  # get '/products/:id' => "products#show"
  patch "/products/:id/edit" => "products#update"
#End of potential problems

  get "/categories" => "categories#index"
  get "/categories/new" => "categories#new"
  post "/categories" => "categories#create"
  get "/categories/:id" => "categories#show", as: :category


  get "/sign-up" => "users#new", as: :sign_up
  # post "/sign-up" => "users#create", as: :sign_up
  # resources :sessions

  
  get "/sign-in" => "sessions#new", as: :sign_in
  post "/sign-in" => "sessions#create", as: :signing_in
  get "/sign-out" => "sessions#destroy", as: :sign_out

  post "/orders/:id/add_product/:product_id" => "orders#add_product", as: :add_product
  get "orders/:id" => "orders#show", as: :order
  delete '/orders/:id/remove_product/:product_id' => "orders#remove_product", as: :remove_product
  patch '/orders/:id/update_quantity/:product_id' => "orders#update_quantity", as: :update_quantity

  get "/search" => "search#show"


  get "users/new"  => "users#new"

  get "products/new" => 'products#new'
  resources :reviews, except: [:new, :create, :index]

  #get "/reviews/:id" => "reviews#show"

  
  # get "users/create"  => "users#create"

  # post "users"        => "users#index"
  # get "users/update"  => "users#update"
  # get "users/edit"    => "users#edit"
  # get "users/destroy" => "users#destroy"
  # get "users/"        => "users#index"
  get "users/:id"     => "users#show"
  get "users/:id/orders/:product_id" => "users#orders", as: :user_orders

  get "/checkout"     => "orders#checkout", as: :checkout
  post "/checkout"    => "orders#submit", as: :pay
  root 'welcome#index'

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
