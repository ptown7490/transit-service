class RoutesController < ApplicationController

  def index
    if params[:agency_id]
      @agency = Agency.find(params[:agency_id])
      @routes = @agency.routes.order(:route_class, :local_id)
    else
      @routes = Route.all.order(:route_class, :local_id)
    end
    json_response(@routes)
  end

  def show
    @route = Route.find(params[:id])
    json_response(@route)
  end

  def stops_list
    @route = Route.find(params[:id])
    @route_direction_a = @route.route_directions.first
    @route_direction_b = @route.route_directions.last

    trip_id = @route_direction_a.canonical_trip_id
    trip = Trip.find(trip_id)

    @left = trip.stop_times.joins(:stop).select("stops.id").order("stop_times.stop_sequence").map do |rec|
      Stop.find(rec[:id])
    end

    trip_id = @route_direction_b.canonical_trip_id
    trip = Trip.find(trip_id)
    
    @right = trip.stop_times.joins(:stop).select("stops.id").order("stop_times.stop_sequence DESC").map do |rec|
      Stop.find(rec[:id])
    end

    offset = @left.count - @right.count
    if Stop.related(@left.first, @right.first)
      if offset > 0
        (offset).times { @right.push(nil) }
      elsif offset < 0
        (-offset).times { @left.push(nil) }
      end
    elsif Stop.related(@left.last, @right.last)
      if offset > 0
        (offset).times { @right.insert(0, nil) }
      elsif offset < 0
        (-offset).times { @left.insert(0, nil) }
      end
    end

    render "stop_sequence.html.erb"
  end
end
