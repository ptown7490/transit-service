class StopTimesController < ApplicationController

  def index
    if params[:trip_id]
      @trip = Trip.find(params[:trip_id])
      @stop_times = @trip.stop_times
    else
      @stop_times = StopTime.all.order(:id)
    end
    @output = @stop_times
    # @output = @stop_times.map do |stop_time|
    #   TimeManagement::convertTimeToSecondsElapsed(stop_time.arrival_time)
    # end
    json_response(@output)
  end
end
