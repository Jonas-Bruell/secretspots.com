Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'secrets/map_data', to: 'secrets#map_data', as: :secrets_map_data

  # Render dynamic PWA files from app/views/pwa/*
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Devise :: https://www.digitalocean.com/community/tutorials/how-to-set-up-user-authentication-with-devise-in-a-rails-7-application
  # Profile picture :: https://www.youtube.com/watch?v=fcoxyZ5mYfQ
  devise_for :users, controllers: {

      omniauth_callbacks: 'users/omniauth_callbacks',
      sessions: "users/sessions",
      registrations: "users/registrations"
  }
  devise_scope :user do
    get "/user/view" => "users/registrations#view"
  end

  # puts locale in the URL
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    # Defines the root path route ("/")
    root "home#index"

    # Following / friending
    post "profile/follow", to: "profile#follow"
    delete "profile/unfollow", to: "profile#unfollow"

    # CRUD for adventures and secrets
    resources :users, only: [:show]

    resources :adventures
    resources :secrets do
      # Nested comments resources under secrets
      resources :comments, only: [:create, :destroy, :edit, :update]
    end
  end

  resources :users, only: [:show]
end
