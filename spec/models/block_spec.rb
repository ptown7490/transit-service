require 'rails_helper'

describe Block do
  it { should validate_presence_of :local_id }

  it { should belong_to :agency }
  it { should have_many :trips }
  it { should have_many :services }
end
