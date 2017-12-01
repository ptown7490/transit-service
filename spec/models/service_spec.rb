require 'rails_helper'

describe Service do
  it { should belong_to :agency }
  it { should have_many :trips }
end
