Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      root 'posts#index'
      post 'auth_user' => 'authentication#authenticate_user'
      resources :posts
      devise_for :users
    end
  end

end
