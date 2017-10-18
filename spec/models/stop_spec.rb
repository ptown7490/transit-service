require 'rails_helper'

describe Stop do
  it { should belong_to :agency }
  it { should have_many :stop_times }
  it { should have_many :children }
  it { should belong_to :parent_station }
  it { should validate_presence_of :local_id }
end
