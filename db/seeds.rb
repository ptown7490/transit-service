DIRPATHS = {
  trimet: './raw data/gtfs/trimet/'
}

class CSVFileParser
  attr_reader :file
  attr_reader :fields
  attr_reader :records

  def initialize(file)
    @file = file
    @records = parse_data
  end

protected
  def get_field_names(line)
    line =~ /[^\n]*$/
    str = $~[0]
    @fields = str.split(/,/)
  end

  def parse_data
    lines = self.file.readlines
    header = lines.shift # extract header line

    get_field_names(header)

    records = []
    lines.each do |element|
      records << parse_record(element)
    end

    records
  end

  def parse_record(line)
    record = {}

    line =~ /[^\n]*$/
    str = $~[0]
    values = str.split(',')
    values.each.with_index do |value, index|
      record[self.fields[index]] = value
    end

    record
  end
end


class Seed
  def self.load_trimet_rail
    trimet_gtfs = DIRPATHS[:trimet]

    agencies = File.new(trimet_gtfs + 'agency.txt')
    stops = File.new(trimet_gtfs + 'stops.txt')
    routes = File.new(trimet_gtfs + 'routes.txt')
    route_directions = File.new(trimet_gtfs + 'route_directions.txt')
    trips = File.new(trimet_gtfs + 'trips.txt')
    stop_times = File.new(trimet_gtfs + 'stop_times.txt')

    trip_blacklist = []

    CSVFileParser.new(agencies).records.each do |record|
      Agency.create!(name: record['agency_name'])
    end
    trimet = Agency.find_by(name: 'TriMet')
    psc = Agency.find_by(name: 'Portland Streetcar')
    tram = Agency.find_by(name: 'Portland Aerial Tram')

    parent_stations = {}
    CSVFileParser.new(stops).records.each do |record|
      stop = trimet.stops.create!(name: record['stop_name'], local_id: record['stop_id'], latitude: record['stop_lat'].to_f, longitude: record['stop_lon'].to_f, location_class: record['location_type'].to_i)
      unless record['parent_station'].nil? || record['parent_station'].empty?
        parent_stations[stop.id] = record['parent_station']
      end
    end
    parent_stations.each do |key, value|
      child = Stop.find(key)
      parent = Stop.find_by(local_id: value)
      child.update(parent_station_id: parent.id)
    end

    CSVFileParser.new(routes).records.each do |record|
      case record['agency_id']
      when 'TRIMET'
        route_class = case record['route_type'].to_i
        when 3
          1 # bus
        when 0
          4 # light rail
        when 2
          5 # commuter rail
        end
        trimet.routes.create!(name: record['route_long_name'], short_name: record['route_short_name'], local_id: record['route_id'], route_class: route_class)
      when 'PSC'
        psc.routes.create!(name: record['route_long_name'], short_name: record['route_short_name'], local_id: record['route_id'], route_class: 3)
      when 'TRAM'
        tram.routes.create!(name: record['route_long_name'], short_name: record['route_short_name'], local_id: record['route_id'], route_class: 7)
      end
    end

    CSVFileParser.new(route_directions).records.each do |record|
      route = Route.find_by(local_id: record['route_id'])
      rd = route.route_directions.create!(direction_id: record['direction_id'].to_i, direction_name: record['direction_name'])
    end

    weekday = Service.create!(agency_id: trimet.id, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: false, sunday: false)
    saturday = Service.create!(agency_id: trimet.id, monday: false, tuesday: false, wednesday: false, thursday: false, friday: false, saturday: true, sunday: false)
    sunday = Service.create!(agency_id: trimet.id, monday: false, tuesday: false, wednesday: false, thursday: false, friday: false, saturday: false, sunday: true)
    mon_to_thurs = Service.create!(agency_id: trimet.id, monday: true, tuesday: true, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false)
    friday = Service.create!(agency_id: trimet.id, monday: false, tuesday: false, wednesday: false, thursday: false, friday: true, saturday: false, sunday: false)

    CSVFileParser.new(trips).records.each do |record|
      route = Route.find_by(local_id: record['route_id'])
      if route.route_class == 4 || route.route_class == 5
        rd = RouteDirection.find_by(route_id: route.id, direction_id: record['direction_id'].to_i)
        service_id =
        case record['service_id']
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
          rd.trips.create!(local_id: record['trip_id'], block_id: record['block_id'].to_i, service_id: service_id)
        else
          trip_blacklist << record['trip_id']
        end
      else
        trip_blacklist << record['trip_id']
      end
    end

    puts "#{Trip.all.count} trips created."
    puts "#{trip_blacklist.count} trips in blacklist."

    CSVFileParser.new(stop_times).records.each do |rec|
      trip = Trip.find_by(local_id: rec['trip_id'])
      if ! trip.nil?
        stop = Stop.find_by(local_id: rec['stop_id'])
        arr = TimeManagement::utc_time(rec['arrival_time'])
        dep = TimeManagement::utc_time(rec['departure_time'])
        trip.stop_times.create!(stop_id: stop.id, stop_sequence: rec['stop_sequence'].to_i, arrival_time: arr, depart_time: dep)
      end
    end

  end

end

Seed.load_trimet_rail
