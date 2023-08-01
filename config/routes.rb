Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      root 'articles#index'
      resources :articles
      devise_for :users
      post 'auth_user' => 'authentication#authenticate_user'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
