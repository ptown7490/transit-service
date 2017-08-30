class RoutesController < ApplicationController

  def index
    @routes = Route.all
    json_response(@routes)
  end
end
