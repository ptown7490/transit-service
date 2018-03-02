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

  def schedule_view
    @route_direction = RouteDirection.find(params[:id])

    if params[:service_id]
      @service = Service.find(params[:service_id])
      serv_id = @service.id
    else
      serv_id = 1
    end

    canonical_trip = Trip.find(@route_direction.canonical_trip_id)
    stop_ids = canonical_trip.stop_times.order(:stop_sequence).map { |stop_time| stop_time.stop_id }

    trips = @route_direction.trips.where(service_id: serv_id)

    @table = ScheduleTableFormatter.new(stop_ids, trips)

    @stop_indices = (0...canonical_trip.stop_times.count).to_a

    render "schedule_table.html.erb"
  end

end
