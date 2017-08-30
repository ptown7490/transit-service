require 'rails_helper'

describe "get all routes route", type: :request do
  let!(:agencies) { Agency.create(name: 'TriMet', id: 1) }
  let!(:routes) { Route.create(name: 'WES Commuter Rail', agency_id: 1, local_id: 203) }

  before do
    get '/routes'
  end

  it 'returns all routes' do
    expect(jsonParseBody(response).size).to eq 1
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
