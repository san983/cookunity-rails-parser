Rails.application.routes.draw do
  get '/test_order', to: redirect('/data.json')

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:show, :index]
    end
  end
end
