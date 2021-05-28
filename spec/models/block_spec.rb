require 'rails_helper'

describe Block do
  it { should validate_presence_of :local_id }

  it { should belong_to :agency }
  it { should have_many :trips }
  it { should have_many :services }

  # NOTE: following code leaves breadcrumbs in the test database
  # describe Block do
  #   before(:all) do
  #     @agency = create(:agency)
  #     route = @agency.routes.create!(name: 'test_route_name', short_name: '', local_id: 'local')
  #     @rd = route.route_directions.create!(direction_id: 0)
  #     @service = Service.create!(agency_id: @agency.id)
  #   end
  #
  #   let!(:agencies) { create(:agency, id: 1) }
  #   let!(:routes) { create(:route, agency_id: 1, id: 2) }
  #   let!(:route_directions) { create(:route_direction)}
  #
  #
  #   before(:each) do
  #     @block_id = 1234
  #     @block = Block.new(@block_id, @agency.id)
  #
  #     (1 .. 10).each do |i|
  #       @rd.trips.create!(block_id: @block_id, service_id: @service.id)
  #     end
  #   end
  #
  #   after(:all) do
  #     @rd.trips.destroy
  #     @rd.destroy
  #     @agency.routes.destroy
  #     @service.destroy
  #     @agency.destroy
  #   end
  #
  #   describe ".block_id" do
  #     it "returns block_id" do
  #       expect(@block.block_id).to eq 1234
  #     end
  #   end
  #
  #   describe ".trips" do
  #     it "" do
  #       expect(@block.trips.count).to eq 10
  #     end
  #   end
  # end
end
