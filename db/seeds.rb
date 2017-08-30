class Seed

  def self.begin
    seed = Seed.new
    seed.generate_agencies
    seed.generate_routes(1)
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
                  short_name: 'WES'
                  )
  end

end

Seed.begin
