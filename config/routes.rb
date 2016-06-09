require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # This is for Amazon Elastic Load Balancer / NewRelic health checks
  get "tests/monitor", to: "status#show"
  get "status/show"

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:show, :index]
    end
  end

  mount Sidekiq::Web, at: '/sidekiq'
end
