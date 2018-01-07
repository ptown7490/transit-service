require 'rails_helper'

describe Service do
  it { should belong_to :agency }
  it { should have_many :trips }
  it { should have_many :route_directions }
  it { should have_many :routes }
  it { should have_many :stop_times }
end
