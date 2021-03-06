Rails.application.routes.draw do
  resources :apidocs, only: [:index, :show]

  devise_for :admins
  devise_for :users, :path_prefix => 'my'
  resources :users

  controller :opportunities do
    get :update_sub_activities
  end

  resources :venue_owners do
    resources :venues
  end

  resources :organisations do
    resources :opportunities
    resources :users do
      get :invite
      get :uninvite
    end
  end

  resources :venue_notices

  resources :effort_ratings do
    delete :index, on: :collection, action: :delete_all
  end

  resources :regions do
    resources :venues
    resources :opportunities
  end

  resources :venues do
    resources :opportunities
  end

  resources :sub_activities

  resources :activities

  get 'welcome/index'
  get 'welcome/api'

  get 'home/index'

  resources :skills

  resources :candidates

  resources :opportunities do
    resources :effort_ratings
    post :rate_effort
  end


  resources :venues, path: "", except: [:index, :new, :create]

  root :to => "welcome#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
