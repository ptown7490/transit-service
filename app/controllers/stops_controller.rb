class StopsController < ApplicationController

  def index
    if params[:agency_id]
      @agency = Agency.find(params[:agency_id])
      @stops = @agency.stops.order(:location_class, :id)
    elsif params[:trip_id]
      @trip = Trip.find(params[:trip_id])
      @stops = @trip.stops
    else
      @stops = Stop.all
    end

    respond_to do |format|
      format.html
      format.json { json_response(@stops) }
    end
  end

  def show
    @stop = Stop.find(params[:id])

    respond_to do |format|
      format.html
      format.json { json_response(@stop) }
    end
  end

end
