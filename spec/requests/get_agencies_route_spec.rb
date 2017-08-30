require 'rails_helper'

describe "get all agencies route", type: :request do
  let!(:agencies) { Agency.create(name: 'TriMet') }

  before { get '/agencies' }

  it 'returns all agencies' do
    expect(jsonParseBody(response).size).to eq 1
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
