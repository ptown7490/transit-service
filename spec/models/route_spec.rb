require 'rails_helper'

describe Route do
  it { should belong_to :agency }
  it { should have_many :route_directions }
  it { should have_many :trips }
  it { should validate_presence_of :local_id }
  it { should validate_presence_of :name }
end
