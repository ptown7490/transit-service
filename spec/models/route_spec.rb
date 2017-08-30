require 'rails_helper'

describe Route do
  it { should belong_to :agency }
  it { should validate_presence_of :local_id }
  it { should validate_presence_of :name }
end
