class StopTimesController < ApplicationController

  def index
    @stop_times = StopTime.all.order(:id)
    @output = @stop_times.map do |stop_time|
      TimeManagement::convertTimeToSecondsElapsed(stop_time.arrival_time)
    end
    json_response(@output)
  end
end
