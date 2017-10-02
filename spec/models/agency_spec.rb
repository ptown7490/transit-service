require 'rails_helper'

describe Agency do
  it { should validate_presence_of :name }

  it { should have_many :routes }
  it { should have_many :stops }
  it { should have_many :route_directions }
  it { should have_many :trips }
end
