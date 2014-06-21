Rails.application.routes.draw do
  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}
  # match "/auth/:provider/callback" => "sessions#create"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  resources :artists do
    member do
      get 'show_twitter_feed'
    end
  end

  get 'home/index' => 'home#index'

  get 'dashboard/index' => 'dashboard#index'
  get 'dashboard/show' => 'dashboard#show'
  get 'dashboard/create_temp_artist' => 'dashboard#create_temp_artist'


  # Non-Resourceful Routes
  get 'admin_manager/index' => 'admin_manager#home'
  get 'admin_manager/home' => 'admin_manager#home'
  get 'admin_manager/find_artist_info' => 'admin_manager#find_artist_info'

  post 'admin_manager/create_artist' => 'admin_manager#create_artist'

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
