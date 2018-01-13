json.(@route_direction, :id, :route_id, :direction_id, :direction_name)

json.service do
  json.name @service[:name]
end

json.stops_list @stops do |stop|
  json.id stop.id
  json.name stop.name
  json.local_id stop.local_id
end

json.trips @trips do |trip|
  json.stop_times trip.stop_times.order(:stop_sequence) do |stop_time|
    json.arrival_time stop_time.arrival_time
  end
end
