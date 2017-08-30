require 'rails_helper'

describe RouteDirection do
  it { should validate_presence_of :direction_id }
  it { should belong_to :route }
  it { should have_many :trips }
end
