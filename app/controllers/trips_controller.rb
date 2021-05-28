class TripsController < ApplicationController

  def index
    if params[:service_id]
      @service_id = params[:service_id]
    end

    if params[:route_id]
      @route = Route.find(params[:route_id])
      if ! @service_id.nil?
        @trips = @route.trips.where(service_id: @service_id).order(:block_id)
      else
        @trips = @route.trips.distinct.select(:service_id)
      end
    elsif params[:route_direction_id]
      @rd = RouteDirection.find(params[:route_direction_id])
      if ! @service_id.nil?
        @trips = @rd.trips.where(service_id: @service_id)
      else
        @trips = @rd.trips
      end
    else
      if ! @service_id.nil?
        @trips = Trip.where(service_id: @service_id).order(:block_id)
      else
        @trips = Trip.all.order(:block_id)
      end
    end
    json_response(@trips)
  end

  def show
    @trip = Trip.find(params[:id])
    @stop_times = @trip.stop_times.order(:stop_sequence)

    respond_to do |format|
      format.html
      format.json { json_response(@trip) }
    end
  end

end
