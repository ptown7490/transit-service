class StopsController < ApplicationController

  def index
    if params[:agency_id]
      @agency = Agency.find(params[:agency_id])
      @stops = @agency.stops
    else
      @stops = Stop.all
    end
    json_response(@stops)
  end

  def show
    @stop = Stop.find(params[:id])
    json_response(@stop)
  end

end
