require 'csv'

class Seed
  DIRPATHS = {trimet: './data/trimet_gtfs/'}

  def self.load_trimet_data_rail_only
    trimet_gtfs = DIRPATHS[:trimet]

    agencies = trimet_gtfs + 'agency.txt'
    stops = trimet_gtfs + 'stops.txt'
    routes = trimet_gtfs + 'routes.txt'
    route_directions = trimet_gtfs + 'route_directions.txt'
    trips = trimet_gtfs + 'trips.txt'
    stop_times = trimet_gtfs + 'stop_times.txt'

    trip_blacklist = []

    CSV.foreach(agencies, headers: true) do |row|
      Agency.create!(name: row['agency_name'])
    end
    trimet = Agency.find_by(name: 'TriMet')
    psc = Agency.find_by(name: 'Portland Streetcar')
    tram = Agency.find_by(name: 'Portland Aerial Tram')

    parent_stations = Hash.new
    CSV.foreach(stops, headers: true) do |row|
      stop = trimet.stops.create!(name: row['stop_name'], local_id: row['stop_id'], latitude: row['stop_lat'].to_f, longitude: row['stop_lon'].to_f, location_class: row['location_type'].to_i)
      unless row['parent_station'].nil? || row['parent_station'].empty?
        parent_stations[stop.id] = row['parent_station']
      end
    end
    parent_stations.each do |key, value|
      child = Stop.find(key)
      parent = Stop.find_by(local_id: value)
      child.update(parent_station_id: parent.id)
    end

    CSV.foreach(routes, headers: true) do |row|
      case row['agency_id']
      when 'TRIMET'
        route_class = case row['route_type'].to_i
        when 3
          1 # bus
        when 0
          4 # light rail
        when 2
          5 # commuter rail
        end
        trimet.routes.create!(name: row['route_long_name'], short_name: row['route_short_name'], local_id: row['route_id'], route_class: route_class)
      when 'PSC'
        psc.routes.create!(name: row['route_long_name'], short_name: row['route_short_name'], local_id: row['route_id'], route_class: 3)
      when 'TRAM'
        tram.routes.create!(name: row['route_long_name'], short_name: row['route_short_name'], local_id: row['route_id'], route_class: 7)
      end
    end

    CSV.foreach(route_directions, headers: true) do |row|
      route = Route.find_by(local_id: row['route_id'])
      rd = route.route_directions.create!(direction_id: row['direction_id'].to_i, direction_name: row['direction_name'])
    end

    weekday = Service.create!(agency_id: trimet.id, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: false, sunday: false)
    saturday = Service.create!(agency_id: trimet.id, monday: false, tuesday: false, wednesday: false, thursday: false, friday: false, saturday: true, sunday: false)
    sunday = Service.create!(agency_id: trimet.id, monday: false, tuesday: false, wednesday: false, thursday: false, friday: false, saturday: false, sunday: true)
    mon_to_thurs = Service.create!(agency_id: trimet.id, monday: true, tuesday: true, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false)
    friday = Service.create!(agency_id: trimet.id, monday: false, tuesday: false, wednesday: false, thursday: false, friday: true, saturday: false, sunday: false)

    CSV.foreach(trips, headers: true) do |row|
      route = Route.find_by(local_id: row['route_id'])
      if route.route_class == 4 || route.route_class == 5
        rd = RouteDirection.find_by(route_id: route.id, direction_id: row['direction_id'].to_i)
        service_id =
        case row['service_id']
        when 'A.489', 'W.495'
          weekday.id
        when 'B.489'
          saturday.id
        when 'C.489'
          sunday.id
        when 'P.489'
          mon_to_thurs.id
        when 'p.489'
          friday.id
        else
          nil
        end

        if ! service_id.nil?
          rd.trips.create!(local_id: row['trip_id'], block_id: row['block_id'].to_i, service_id: service_id)
        else
          trip_blacklist << row['trip_id']
        end
      else
        trip_blacklist << row['trip_id']
      end
    end

    puts "#{Trip.all.count} trips created."
    puts "#{trip_blacklist.count} trips in blacklist."

    CSV.foreach(stop_times, headers: true) do |row|
      trip = Trip.find_by(local_id: row['trip_id'])
      if ! trip.nil?
        stop = Stop.find_by(local_id: row['stop_id'])
        arr = TimeManagement::utc_time(row['arrival_time'])
        dep = TimeManagement::utc_time(row['departure_time'])
        trip.stop_times.create!(stop_id: stop.id, stop_sequence: row['stop_sequence'].to_i, arrival_time: arr, depart_time: dep)
      end
    end


  end

end

Seed.load_trimet_data_rail_only
