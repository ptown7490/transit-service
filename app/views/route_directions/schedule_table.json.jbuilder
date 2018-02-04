json.(@route_direction, :id, :route_id, :direction_id, :direction_name)

json.service do
  json.name @service[:name]
end

json.stops_list @table.header do |stop|
  json.id stop.id
  json.name stop.name
  json.local_id stop.local_id
end

json.trips @table.body do |trip|
  stop_times = trip.map do |time|
    if time.nil?
      time
    else
      time.to_i
    end
  end
  json.stop_times stop_times
end
