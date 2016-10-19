Rails.application.routes.draw do
  root "static_pages#root"
  resources :cors
  get "/request" => "api/players#get_request_token"
  get "/callback" => "api/players#callback"
  namespace :api, defaults: {format: :json} do
    resources :players, only: [:index]
  end

  get 'api/players/favorites', :to => 'api/players#favorites'

end
