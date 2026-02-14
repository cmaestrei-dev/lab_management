Rails.application.routes.draw do
  root "home#index"
  get "home/index"
  resources :reports
  resources :components
  resources :computers
  resources :laboratories
  resources :professors

  namespace :api do
    namespace :v1 do
      resources :reports, only: [:index, :create, :show, :update]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end