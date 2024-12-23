Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'secrets/map_data', to: 'secrets#map_data', as: :secrets_map_data

  # Render dynamic PWA files from app/views/pwa/*
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # puts locale in the URL
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    # Defines the root path route ("/")
    root "home#index"

    # Devise :: https://www.digitalocean.com/community/tutorials/how-to-set-up-user-authentication-with-devise-in-a-rails-7-application
    # Profile picture :: https://www.youtube.com/watch?v=fcoxyZ5mYfQ
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }
    devise_scope :user do
      get "/user/view" => "users/registrations#view"
    end

    # Following
    post "users/follow", to: "users#follow"
    delete "users/unfollow", to: "users#unfollow"

    get "users/:id/followers", to: "users#followers", as: "followers"
    get "users/:id/following", to: "users#following", as: "following"

    # CRUD for adventures and secrets
    resources :users, only: [:show]

    resources :adventures
    resources :secrets do
      # Nested comments resources under secrets
      resources :comments, only: [:create, :destroy, :edit, :update]
    end
  end
end
