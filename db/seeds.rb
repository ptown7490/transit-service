class Seed

  def self.begin
    seed = Seed.new
    seed.generate_agencies
    seed.generate_routes(1)
    seed.generate_route_directions(1)
  end

  def generate_agencies
    Agency.create!(name: 'TriMet',
                   id:    1
                   )
  end

  def generate_routes(agency_id)
    Route.create!(agency_id:  agency_id.to_i,
                  local_id:   203,
                  name:       'WES Commuter Rail',
                  short_name: 'WES',
                  id:         1
                  )
  end

  def generate_route_directions(route_id)
    RouteDirection.create!(route_id:        route_id.to_i,
                           direction_id:    0,
                           direction_name:  'To Wilsonville'
                          )
    RouteDirection.create!(route_id:        route_id.to_i,
                           direction_id:    1,
                           direction_name:  'To Beaverton'
                          )
  end

end

Seed.begin
