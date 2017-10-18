class TripsController < ApplicationController

  def index
    if params[:route_id]
      @route = Route.find(params[:route_id])
      @trips = @route.trips
    elsif params[:route_direction_id]
      @rd = RouteDirection.find(params[:route_direction_id])
      @trips = @rd.trips
    else
      @trips = Trip.all.order(:block_id)
    end
    json_response(@trips)
  end

  def show
    @trip = Trip.find(params[:id])
    json_response(@trip)
  end

end
