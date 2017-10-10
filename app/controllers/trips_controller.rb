class TripsController < ApplicationController

  def index
    if params[:route_id]
      @route = Route.find(params[:route_id])
      @trips = @route.trips
    else
      @trips = Trip.all
    end
    json_response(@trips)
  end

  def show
    @trip = Trip.find(params[:id])
    json_response(@trip)
  end

end
