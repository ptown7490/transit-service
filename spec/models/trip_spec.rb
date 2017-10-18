require 'rails_helper'

describe Trip do
  it { should belong_to :route_direction }
  it { should have_many :stop_times }
  it { should have_many :stops }
  it { should have_one :route }
  it { should have_one :agency }
  it { should validate_presence_of :service_id }
end
