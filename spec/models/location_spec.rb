require 'rails_helper'

describe Location do
  it { should have_many :stops }
  it { should belong_to :parent_location }
end
