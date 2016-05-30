Rails.application.routes.draw do
  resources :orders

  get '/test_order', to: redirect('/data.json')
end
