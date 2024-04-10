# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout'

    root 'bulletins#index'
    resources :bulletins, except: %i[destroy] do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    scope module: :profile do
      get 'profile', to: 'home#index'
    end

    namespace :admin do
      root 'home#index'
      resources :categories, except: %i[show]
      resources :bulletins, only: %i[index] do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
    end
  end
end
