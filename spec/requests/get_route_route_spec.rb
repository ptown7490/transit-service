require 'rails_helper'

describe "get specific route route", type: :request do
  let!(:agencies) { create(:agency, id: 1) }
  let!(:routes) { create(:route, name: 'WES Commuter Rail', agency_id: 1, local_id: '203', id: 1) }

  before do
    get '/routes/1'
  end

  it 'returns the route name' do
    expect(jsonParseBody(response)['name']).to eq 'WES Commuter Rail'
  end

  it 'returns the route local_id' do
    expect(jsonParseBody(response)['local_id']).to eq '203'
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  context "when route is not found" do
    before do
      get '/routes/2'
    end

    it 'returns status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
