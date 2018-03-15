class BlocksController < ApplicationController

  def index
    @agency_id = params[:agency_id]
    @blocks = Block.all(@agency_id)

    json_response(@blocks)
  end

  def show
    @agency_id = params[:agency_id]
    @block = Block.find(params[:id], @agency_id)
    if params[:service_id]
      @services = [
        {
          service_id: params[:service_id],
          trips: @block.trips(params[:service_id])
        }
      ]
      @trips = @block.trips(params[:service_id])
    else
      @services = []
      @block.services.each do |service|
        service_id = service[:service_id]
        @services << {service_id: service[:service_id], trips: @block.trips(service_id)}
      end
      @trips = @block.trips
    end

    respond_to do |format|
      format.html
      format.json { json_response(@trips) }
    end
  end

end
