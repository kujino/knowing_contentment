Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    password: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  get "mypage" => "mypages#show"

  resources :posts, param: :uuid, only: [ :new, :create, :show, :index, :edit, :update, :destroy ] do
    collection do
      get :reactions
      get :mine
    end
  end
  resources :reactions, only: [ :create, :destroy, :index ]
  resources :books, only: [ :index ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "static_pages#top"
end
