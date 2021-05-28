module V1
  class BlocksController < ApplicationController

    def routes
      route_id = params[:route_id]
      # route_ids = params[:route_ids]
      service_id = params[:service_id]

      route = Route.find(route_id)
      # routes = Route.find(route_ids) # NOTE: need returned as ActiveRecord::Relation
      @routes = [ Route.find(route_id) ]
      @service = Service.find(service_id)

      @route_directions = route.route_directions
      @blocks = @route_directions.map do |rd|
        rd.blocks_for_service(service_id)
      end.flatten.uniq

      @locations = Location.find(@route_directions.first.ordered_location_ids)

      render "block_course.json.jbuilder"
    end

  end
end
