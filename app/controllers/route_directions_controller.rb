class RouteDirectionsController < ApplicationController

  def index
    if params[:agency_id]
      @agency = Agency.find(params[:agency_id])
      @route_directions = @agency.route_directions
    elsif params[:route_id]
      @route = Route.find(params[:route_id])
      @route_directions = @route.route_directions.order(:direction_id)
    else
      @route_directions = RouteDirection.all
    end
    json_response(@route_directions)
  end

  def show
    @route_direction = RouteDirection.find(params[:id])
    json_response(@route_direction)
  end

end
