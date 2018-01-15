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

    canonical_trip = Trip.find(@route_direction.canonical_trip_id)
    stop_ids = canonical_trip.stop_times.order(:stop_sequence).map { |stop_time| stop_time.stop_id }
    stop_count = stop_ids.count

    @stops = stop_ids.map { |stop_id| Stop.find(stop_id) }

    serv_id = 1
    @service = { name: 'Weekday' }
    @trips = @route_direction.trips.where(service_id: serv_id).sort_by(&:start_time)

    schedule_grid = []
    @trips.each do |trip|
      row = Array.new(stop_count, nil)

      trip.stop_times.order(:stop_sequence).each do |stop_time|
        idx = stop_ids.index(stop_time.stop_id)
        unless idx.nil?
          row[idx] = stop_time.arrival_time.to_i
        end
      end

      schedule_grid << row
    end

    @schedule_grid = schedule_grid

    render "schedule_table.json.jbuilder"
  end
end
