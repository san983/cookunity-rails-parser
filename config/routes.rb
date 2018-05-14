require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # This is for Amazon Elastic Load Balancer / NewRelic health checks
  get "tests/monitor", to: "status#show"
  get "status/show"

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:show, :index]
      post "cancel_meals", to: "cancel_meals#create"
    end
  end

  mount Sidekiq::Web, at: '/sidekiq'

  root 'status#nothing'
  get '*path', to: "status#nothing"
end
