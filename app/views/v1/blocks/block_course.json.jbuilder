json.route_directions @route_directions do |rd|
  json.id rd.id
  json.direction_name rd.direction_name
  json.route_id rd.route.id
end

json.blocks @blocks do |block|
  json.id block.id
  json.trips block.ordered_trips_for_service(@service.id) do |trip|
    json.route_direction_id trip.route_direction_id
    json.stop_times trip.ordered_stop_times do |stop_time|
      json.location_id stop_time.stop.location_id
      json.time stop_time.arrival_time.to_i
    end
  end
end

json.locations @locations do |location|
  json.id location.id
  json.label location.default_label
end

json.service_id @service.id

json.routes @routes do |route|
  json.id route.id
  json.name route.name
end
