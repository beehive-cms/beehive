Beehive::Engine.add_routes do
  devise_for :users, path: :auth, class_name: 'Beehive::User', module: :devise

  namespace :admin, path: Beehive.admin_path do
    root to: 'dashboard#index'

    resources :media, path: :media
    resources :users
    resource :settings, only: [:show] do
      resource :general, only: %i[edit update], on: :collection, module: :settings, controller: :general
    end

    put 'reorder/:model', to: 'utilities#reorder'
  end

  namespace :api do
    namespace :v1 do
      jsonapi_resources :users
      jsonapi_resources :roles
      jsonapi_resources :media
    end
  end
end

Beehive::Engine.draw_routes
