Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  get '/login', to: 'api/v1/users/sessions#new'

  namespace :api do
    namespace :v1 do
      post '/login', to: 'users/sessions#login'
      get '/global_state', to: 'users/user_info#global_state'

      resources :post_videos, only: %i[index create]
    end
  end
end
