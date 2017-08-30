class Seed

  WES_SCHEDULE = [
    # to Wilsonville
    '05:58', '06:03', '06:09', '06:15', '06:25',
    '06:28', '06:33', '06:39', '06:45', '06:55',
    '06:58', '07:03', '07:09', '07:15', '07:25',
    '07:28', '07:33', '07:39', '07:45', '07:55',
    '07:58', '08:03', '08:09', '08:15', '08:25',
    '08:28', '08:33', '08:39', '08:45', '08:55',
    '08:58', '09:03', '09:09', '09:15', '09:25',
    '09:28', '09:33', '09:39', '09:45', '09:55',

    '16:05', '16:10', '16:16', '16:22', '16:32',
    '16:35', '16:40', '16:46', '16:52', '17:02',
    '17:05', '17:10', '17:16', '17:22', '17:32',
    '17:35', '17:40', '17:46', '17:52', '18:02',
    '18:05', '18:10', '18:16', '18:22', '18:32',
    '18:35', '18:40', '18:46', '18:52', '19:02',
    '19:05', '19:10', '19:16', '19:22', '19:32',
    '19:35', '19:40', '19:46', '19:52', '20:02',


    # to Beaverton TC
    '05:21', '05:31', '05:39', '05:43', '05:48',
    '05:51', '06:01', '06:09', '06:13', '06:18',
    '06:21', '06:31', '06:39', '06:43', '06:48',
    '06:51', '07:01', '07:09', '07:13', '07:18',
    '07:21', '07:31', '07:39', '07:43', '07:48',
    '07:51', '08:01', '08:09', '08:13', '08:18',
    '08:21', '08:31', '08:39', '08:43', '08:48',
    '08:51', '09:01', '09:09', '09:13', '09:18',

    '15:28', '15:38', '15:46', '15:50', '15:55',
    '15:58', '16:08', '16:16', '16:20', '16:25',
    '16:28', '16:38', '16:46', '16:50', '16:55',
    '16:58', '17:08', '17:16', '17:20', '17:25',
    '17:28', '17:38', '17:46', '17:50', '17:55',
    '17:58', '18:08', '18:16', '18:20', '18:25',
    '18:28', '18:38', '18:46', '18:50', '18:55',
    '18:58', '19:08', '19:16', '19:20', '19:25'
  ]

  def self.begin
    seed = Seed.new
    seed.generate_agencies
    seed.generate_routes(1)
    seed.generate_route_directions(1)
    seed.generate_stops(1)
    seed.generate_trips
    seed.generate_stop_times
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
                 local_id:   '130668',
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

  def generate_trips
    16.times do
      Trip.create!(route_direction_id:  0)
    end # make 16 trips to Wilsonville
    16.times do
      Trip.create!(route_direction_id:  1)
    end # make 16 trips to Beaverton TC
  end

  def generate_stop_times
    # to Wilsonville
    0.upto(15) do |num|
      0.upto(4) do |offset|
        StopTime.create!(stop_id:       offset+1,
                         trip_id:       num+1,
                         stop_sequence: offset+1,
                         arrival_time:  WES_SCHEDULE[num*5+offset],
                         depart_time:   WES_SCHEDULE[num*5+offset]
                        )
      end
    end

    # to Beaverton TC
    16.upto(31) do |num|
      0.upto(4) do |offset|
        stop_id = (offset+1 == 3 ? 6 : offset+1) # correct stop_id for Tigard TC, northbound platform
        StopTime.create!(stop_id:       stop_id,
                         trip_id:       num+1,
                         stop_sequence: offset+1,
                         arrival_time:  WES_SCHEDULE[num*5+offset],
                         depart_time:   WES_SCHEDULE[num*5+offset]
                        )
      end
    end
  end

end

Seed.begin
