require 'rails_helper'

describe Stop do
  it { should belong_to :agency }
  it { should have_many :stop_times }
  it { should validate_presence_of :local_id }
end
