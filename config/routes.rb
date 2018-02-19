Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  def api_version(version, &routes)
    api_constraint = ApiConstraint.new(version: version)

    constraints api_constraint do
      scope(module: "v#{version}", &routes)
    end
  end

  resources :agencies do
    resources :routes, only: [:index]
    resources :stops, only: [:index]
  end
  resources :stops, only: [:index, :show]

  resources :routes, only: [:index, :show] do
    resources :trips, only: [:index]
    resources :route_directions, only: [:index]
  end
  resources :trips, only: [:index, :show] do
    resources :stop_times, only: [:index]
    resources :stops, only: [:index]
  end
  resources :stop_times, only: [:index]

  resources :route_directions, only: [:index, :show] do
    resources :trips, only: [:index]
    resources :stop_times, only: [:index]
  end

  api_version(1) do
    defaults format: :json do
      get 'route_directions/:id/schedule', to: 'route_directions#schedule'
    end

    get 'route_directions/:id/schedule_table_view', to: 'route_droute_directions#schedule_view'
  end


end
