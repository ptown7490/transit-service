require 'rails_helper'

describe Service do
  it { should belong_to :agency }
  it { should have_many :trips }
  it { should validate_presence_of :monday }
  it { should validate_presence_of :tuesday }
  it { should validate_presence_of :wednesday }
  it { should validate_presence_of :thursday }
  it { should validate_presence_of :friday }
  it { should validate_presence_of :saturday }
  it { should validate_presence_of :sunday }
end
