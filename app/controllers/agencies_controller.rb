class AgenciesController < ApplicationController

  def index
    @agencies = [
        {
          "id": 1,
          "name": 'TriMet'
        }
      ]
    json_response(@agencies)
  end

  private
  def json_response(object)
    render json: object, status: :ok
  end
end
