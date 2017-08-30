class Agency < ActiveRecord::Base
  has_many :routes
  has_many :route_directions, through: :routes

  validates :name, presence: true
end
