require 'rails_helper'

describe Trip do
  it { should belong_to :route_direction }
end
