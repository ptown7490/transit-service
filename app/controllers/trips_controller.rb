class TripsController < ApplicationController

  def index
    @trips = Trip.all
    json_response(@trips)
  end

end
