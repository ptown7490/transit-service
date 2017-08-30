require 'rails_helper'

describe "post an agency route", type: :request do

  before do
    post '/agencies', params: { name: 'CTA' }
  end

  it 'returns the agency name' do
    expect(JSON.parse(response.body)['name']).to eq 'CTA'
  end

  it 'returns a created status' do
    expect(response).to have_http_status(:created)
  end
end

describe "post an agency route (misused)", type: :request do

  before do
    post '/agencies', params: { }
  end

  it 'returns a status of 500 when params are invalid' do
    expect(response).to have_http_status(500)
  end
end
