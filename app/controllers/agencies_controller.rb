class AgenciesController < ApplicationController

  def index
    @agencies = Agency.all
    json_response(@agencies)
  end

  private
  def json_response(object)
    render json: object, status: :ok
  end
end
