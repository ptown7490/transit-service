class StopTimesController < ApplicationController

  def index
    if params[:trip_id]
      @trip = Trip.find(params[:trip_id])
      @stop_times = @trip.stop_times.order(:trip_id, :stop_sequence)
    else
      @stop_times = StopTime.all.order(:trip_id, :stop_sequence).limit(50)
    end
    json_response(@stop_times)
  end
end
