Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :agencies do
    resources :routes, only: [:index]
    resources :stops, only: [:index]
  end
  resources :stops, only: [:index, :show]
  resources :routes, only: [:index, :show] do
    resources :trips, only: [:index]
  end
  resources :trips, only: [:index, :show] do
    resources :stop_times, only: [:index]
  end
  resources :stop_times, only: [:index]
end
