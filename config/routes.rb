Rails.application.routes.draw do
  root "static_pages#root"
  namespace :api, defaults: {format: :json} do
    resources :players, only: [:create, :show, :update, :index]
  end
end
