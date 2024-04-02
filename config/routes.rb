# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout'

    root 'bulletins#index'

    scope module: :profile do
      get 'profile', to: 'bulletins#index'
      resources :bulletins, only: %i[new create edit update]
    end

    resources :bulletins, only: %i[index show]

    namespace :admin do
      root 'home#index'
      resources :categories, except: %i[show]
      resources :users, only: %i[index show edit update]
      resources :bulletins, only: :index
    end
  end
end
