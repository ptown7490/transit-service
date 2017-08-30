class Trip < ActiveRecord::Base
  belongs_to :route_direction
  has_many :stop_times

end
