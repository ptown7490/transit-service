class BlocksController < ApplicationController

  def index
    agency_id = params[:agency_id]
    @agency = Agency.find(agency_id)
    @blocks = @agency.blocks

    json_response(@blocks)
  end

  def show
    agency_id = params[:agency_id]
    @agency = Agency.find(agency_id)
    @block = Block.find(params[:id])
    if params[:service_id]
      @services = [
        {
          service_id: params[:service_id],
          trips: @block.trips.where(service_id: params[:service_id])
        }
      ]
      @trips = @block.trips.where(service_id: params[:service_id]).sort_by(&:start_time)
    else
      @services = @block.services.order(:id).map do |service|
        service_id = service.id
        {service_id: service_id, trips: @block.trips.where(service_id: service_id).sort_by(&:start_time)}
      end
      @trips = @block.trips.sort_by(&:start_time)
    end

    respond_to do |format|
      format.html
      format.json { json_response(@trips) }
    end
  end

end
