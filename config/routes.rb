Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  def api_version(version, &routes)
    api_constraint = ApiConstraint.new(version: version)

    constraints api_constraint do
      scope(module: "v#{version}", &routes)
    end
  end

  root to: 'home#index'

  resources :agencies do
    resources :routes, only: [:index]
    resources :stops, only: [:index]
    resources :blocks, only: [:index, :show]
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

  get 'route_directions/:id/schedule_table_view', to: 'route_directions#schedule_view'
  get 'routes/:id/stops', to: 'routes#stops_list'

  api_version(1) do
    defaults format: :json do
      get 'route_directions/:id/schedule', to: 'route_directions#schedule'
      get 'agencies/:agency_id/blocks_routes', to: 'blocks#routes' # TODO: rename
    end
  end
  

end
