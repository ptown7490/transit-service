class Service < ActiveRecord::Base
  belongs_to :agency
  has_many :trips
  has_many :route_directions,  -> { distinct }, through: :trips
  has_many :routes,  -> { distinct }, through: :route_directions
  has_many :stop_times, through: :trips
  has_many :blocks, -> { distinct }, through: :trips

end
