class AgenciesController < ApplicationController

  def index
    @agencies = Agency.all
    json_response(@agencies)
  end

  def show
    @agency = Agency.find(params[:id])
    json_response(@agency)
  end

  def create
    @agency = Agency.create(agency_params)
    json_response(@agency)
  end

  def update
    @agency = Agency.find(params[:id])
    @agency.update(agency_params)
  end

  def destroy
    @agency = Agency.find(params[:id])
    @agency.destroy
  end

  private
  def json_response(object)
    render json: object, status: :ok
  end

  def agency_params
    params.require(:agency).permit(:name)
  end
end
