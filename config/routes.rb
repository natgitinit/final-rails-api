Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      root 'articles#index'
      resources :articles
      devise_for :users
      post 'auth_user' => 'authentication#authenticate_user'
    end
  end

end
