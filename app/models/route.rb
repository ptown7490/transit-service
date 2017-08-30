class Route < ActiveRecord::Base
  belongs_to :agency
  has_many :route_directions

  validates :local_id, presence: true
  validates :name, presence: true
end
