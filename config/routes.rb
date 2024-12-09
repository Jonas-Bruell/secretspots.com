Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  root "home#index"


  get "up" => "rails/health#show", as: :rails_health_check



  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get 'secrets/map_data', to: 'secrets#map_data', as: :secrets_map_data



  devise_for :users

  # CRUD

  resources :adventures
  resources :secrets

  Rails.logger.info "Routes loaded successfully!"
end
