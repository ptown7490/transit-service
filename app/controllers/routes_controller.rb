class RoutesController < ApplicationController

  def index
    if params[:agency_id]
      @agency = Agency.find(params[:agency_id])
      @routes = @agency.routes.order(:route_class, :local_id)
    else
      @routes = Route.all.order(:route_class, :local_id)
    end
    json_response(@routes)
  end

  def show
    @route = Route.find(params[:id])
    json_response(@route)
  end
end
