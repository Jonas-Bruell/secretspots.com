Rails.application.routes.draw do
  # Adding logging to monitor route loading
  Rails.logger.info "Loading routes..."

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  Rails.logger.info "Defining root route"
  puts "Debug: Root route is being loaded"
  root "home #index"

  Rails.logger.info "Defining health check route"
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  Rails.logger.info "Defining PWA routes"
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest


  # Devise authentication routes
  Rails.logger.info "Defining Devise routes"
  devise_for :users

  # CRUD
  Rails.logger.info "Defining CRUD routes"
  resources :adventures [:index]
  resources :secrets [:index]

  Rails.logger.info "Routes loaded successfully!"
end
