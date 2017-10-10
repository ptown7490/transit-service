class RoutesController < ApplicationController

  def index
    if params[:agency_id]
      @agency = Agency.find(params[:agency_id])
      @routes = @agency.routes
    else
      @routes = Route.all
    end
    json_response(@routes)
  end

  def show
    @route = Route.find(params[:id])
    json_response(@route)
  end
end
