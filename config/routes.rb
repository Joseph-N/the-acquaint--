Acquianter::Application.routes.draw do
  resources :users do
    resources :comments, only: [:create, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  resources :microposts, only: [:create, :destroy]
  
  root :to => 'users#new'

  match '/home', to: 'static_pages#home'
  match '/about', to: 'static_pages#about'
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match "/users/:id/rate", to: 'users#rate', as: 'rate_user', via: :post
  match '/users/:id/vote_up', to: 'users#vote_up', as: 'vote_up', via: :post
  match '/users/:id/vote_down', to: 'users#vote_down', as: 'vote_down', via: :post
  match '/users/:id/average', to: 'users#average', via: :get
  match '/users/:id/comments/more', to: 'comments#more_comments', as: 'more', via: :post
  match '/home/refresh', to: 'microposts#check_new_updates'
  match '/home/load_new_microposts', to: 'microposts#load_new_microposts'
  match '/home/load_microposts_on_scroll', to: 'microposts#load_on_scroll'
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
