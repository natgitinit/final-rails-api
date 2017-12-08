Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      root 'articles#index'
      resources :articles
      devise_for :users
      post 'auth_user' => 'authentication#authenticate_user'
      get '/scrape', to: 'images#scrape'
      get '/images', to: 'images#index'
      get '/api_sources', to: 'images#fetch_sources_from_api'
    end
  end

end
