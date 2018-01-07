class Route < ActiveRecord::Base
  belongs_to :agency
  has_many :route_directions
  has_many :trips, through: :route_directions
  has_many :services, -> { distinct }, through: :route_directions

  validates :local_id, presence: true
  validates :name, presence: true
end
