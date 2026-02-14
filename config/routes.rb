Rails.application.routes.draw do
  resources :reports
  resources :components
  resources :computers
  resources :laboratories
  resources :professors
  
  namespace :api do
    namespace :v1 do
      resources :reports, only: [:index]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end