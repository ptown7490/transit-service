class StopTime < ActiveRecord::Base
  belongs_to :stop
  belongs_to :trip

  validates :stop_sequence, presence: true
end
