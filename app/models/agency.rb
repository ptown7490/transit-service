class Agency < ActiveRecord::Base
  has_many :routes
  has_many :stops

  has_many :route_directions, through: :routes
  has_many :trips, through: :route_directions

  validates :name, presence: true
end
