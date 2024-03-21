# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resource :session, only: %i[destroy]

    root 'bulletins#index'

    scope module: :profile do
      resources :bulletins, only: %i[new create]
    end

    resources :bulletins, only: %i[index show]
  end
end
