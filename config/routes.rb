Rails.application.routes.draw do

  root to: "posts#index"

  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      resources :posts
      devise_for :users
    end
  end

end
