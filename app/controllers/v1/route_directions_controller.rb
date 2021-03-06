module V1
  class RouteDirectionsController < ApplicationController

    def schedule
      @route_direction = RouteDirection.find(params[:id])

      if params[:service_id]
        @service = Service.find(params[:service_id])
        serv_id = @service.id
      else
        serv_id = 1
        @service = { name: 'Weekday' }
      end

      begin
        canonical_trip = Trip.find(@route_direction.canonical_trip_id)
      rescue => exception
        json_response({message: 'Could not find canonical_trip for route_direction' }, :not_found)
      else
        stop_ids = canonical_trip.stop_times.order(:stop_sequence).map { |stop_time| stop_time.stop_id }
        trips = @route_direction.trips.where(service_id: serv_id)

        @table = ScheduleTableFormatter.new(stop_ids, trips)
        render "schedule_table.json.jbuilder"
      end
    end
    
  end
end
