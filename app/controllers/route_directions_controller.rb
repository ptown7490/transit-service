class RouteDirectionsController < ApplicationController

  def index
    if params[:agency_id]
      @agency = Agency.find(params[:agency_id])
      @route_directions = @agency.route_directions
    elsif params[:route_id]
      @route = Route.find(params[:route_id])
      @route_directions = @route.route_directions.order(:direction_id)
    else
      @route_directions = RouteDirection.all
    end
    json_response(@route_directions)
  end

  def show
    @route_direction = RouteDirection.find(params[:id])
    json_response(@route_direction)
  end

  def schedule
    @route_direction = RouteDirection.find(params[:id])
    @service = { name: 'Weekday' }
    canonical_trip = @route_direction.trips.take
    canonical_trip.stop_times.order(:stop_sequence)
    stop_ids = canonical_trip.stop_times.order(:stop_sequence).map { |stop_time| stop_time.stop_id }
    @stops = stop_ids.map { |stop_id| Stop.find(stop_id) }
    @trips = @route_direction.trips.sort_by(&:start_time)
    
    render "schedule_table.json.jbuilder"
  end
end
