Rails.application.routes.draw do
  devise_for :users
  #devise_for :users, :controllers => { registrations: 'registrations' }

  # # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root 'application#index', as: 'index'

  get 'maptrip(/:id)' => 'trips#maptrip', defaults: {format: :json}

  get 'users/:id/trips' => 'trips#user_list', as: 'trip_from_user'

  get 'trips/index' => 'trips#index', as: 'trip_index'
  get 'trips/new' => 'trips#new', as: 'create_new_trip'

  get 'trips/:trip_id/stages/:stage_id/comments' => 'stage_comments#stage_list', as: 'comments_for_stage'

  resources :trips do
    resources :stages do
      resources :image_stage
      resources :stage_comments
    end
  end

  #get 'trips/:id_trip/edit_stage/:id_stage' => 'trips#edit_stage', :as => 'edit_stage'

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
