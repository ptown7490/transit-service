class StopTimesController < ApplicationController

  def index
    if params[:trip_id]
      @trip = Trip.find(params[:trip_id])
      @stop_times = @trip.stop_times.order(:trip_id, :stop_sequence)
    elsif params[:route_direction_id]
      @rd = RouteDirection.find(params[:route_direction_id])
      @stop_times = []
      if params[:service_id]
        trips = @rd.trips.where(service_id: params[:service_id])
        trips.each do |trip|
          @stop_times << trip.stop_times.order(:stop_sequence)
        end
      end
    else
      @stop_times = StopTime.all.order(:trip_id, :stop_sequence).limit(50)
    end
    json_response(@stop_times)
  end
end
