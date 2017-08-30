class RoutesController < ApplicationController

  def index
    @routes = Route.all
    json_response(@routes)
  end

  def show
    @route = Route.find(params[:id])
    json_response(@route)
  end
end
