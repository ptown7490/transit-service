class Seed

  def self.begin
    seed = Seed.new
    seed.generate_agencies
    seed.generate_routes(1)
    seed.generate_route_directions(1)
    seed.generate_stops(1)
  end

  def generate_agencies
    Agency.create!(name: 'TriMet',
                   id:    1
                   )
  end

  def generate_routes(agency_id)
    Route.create!(agency_id:  agency_id.to_i,
                  local_id:   '203',
                  name:       'WES Commuter Rail',
                  short_name: 'WES',
                  id:         1
                  )
  end

  def generate_route_directions(route_id)
    RouteDirection.create!(route_id:        route_id.to_i,
                           direction_id:    0,
                           direction_name:  'To Wilsonville',
                           id:              0
                          )
    RouteDirection.create!(route_id:        route_id.to_i,
                           direction_id:    1,
                           direction_name:  'To Beaverton',
                           id:              1
                          )
  end

  def generate_stops(agency_id)
    Stop.create!(agency_id:  agency_id.to_i,
                 local_id:   '13066',
                 name:       'Beaverton TC WES Station',
                 latitude:   45.49064,
                 longitude:  -122.801157,
                 id:         1
                )
    Stop.create!(agency_id:  agency_id.to_i,
                 local_id:   '13067',
                 name:       'Hall/Nimbus WES Station',
                 latitude:   45.457587,
                 longitude:  -122.786997,
                 id:         2
                )
    Stop.create!(agency_id:  agency_id.to_i,
                 local_id:   '13066',
                 name:       'Tigard TC WES Station',
                 latitude:   45.429936,
                 longitude:  -122.769527,
                 id:         3
                )
    Stop.create!(agency_id:  agency_id.to_i,
                 local_id:   '13069',
                 name:       'Tualatin WES Station',
                 latitude:   45.383621,
                 longitude:  -122.764504,
                 id:         4
                )
    Stop.create!(agency_id:  agency_id.to_i,
                 local_id:   '13070',
                 name:       'Wilsonville WES Station',
                 latitude:   45.311358,
                 longitude:  -122.775303,
                 id:         5
                )
    Stop.create!(agency_id:  agency_id.to_i,
                 local_id:   '13073',
                 name:       'Tigard TC WES Station',
                 latitude:   45.430229,
                 longitude:  -122.769834,
                 id:         6
                )
  end

end

Seed.begin
