require 'rails_helper'

describe Stop do
  it { should belong_to :agency }
  it { should validate_presence_of :local_id }
end
