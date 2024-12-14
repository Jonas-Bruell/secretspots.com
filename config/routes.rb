Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Devise :: https://www.digitalocean.com/community/tutorials/how-to-set-up-user-authentication-with-devise-in-a-rails-7-application
  # https://dev.to/ahmadraza/google-login-in-rails-7-with-devise-2gpo#step-3-configure-controller#step-4-add-routes
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # puts locale in the URL
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    # Defines the root path route ("/")
    root "home#index"

    # CRUD for adventures and secrets
    resources :adventures
    resources :secrets do
      # Nested comments resources under secrets
      resources :comments, only: [:create, :destroy], shallow: true
    end
  end
end
