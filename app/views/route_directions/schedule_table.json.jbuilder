json.(@route_direction, :id, :route_id, :direction_id, :direction_name)

json.service do
  json.name @service[:name]
end

json.stops_list @stops do |stop|
  json.id stop.id
  json.name stop.name
  json.local_id stop.local_id
end

json.trips @schedule_grid do |trip|
  json.stop_times trip
end
