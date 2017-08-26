require 'rails_helper'

describe Agency do
  it { should validate_presence_of :name }
end
