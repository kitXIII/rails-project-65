# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout'

    root 'bulletins#index'
    resources :bulletins, except: %i[destroy]

    namespace :profile do
      root 'home#index'
    end

    namespace :admin do
      root 'home#index'
      resources :categories, except: %i[show]
      resources :users, only: %i[index show edit update]
      resources :bulletins, only: :index
    end
  end
end
