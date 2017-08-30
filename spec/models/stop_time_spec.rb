require 'rails_helper'

describe StopTime do
  it { should belong_to :stop }
  it { should belong_to :trip }
  it { should validate_presence_of :stop_sequence }
end
