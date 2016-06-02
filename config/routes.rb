require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders, only: [:show, :index]
    end
  end

  mount Sidekiq::Web, at: '/sidekiq'
end
