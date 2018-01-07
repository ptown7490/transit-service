class RouteDirection < ActiveRecord::Base
  belongs_to :route
  has_many :trips
  has_many :services,  -> { distinct }, through: :trips

  validates :direction_id, presence: true
end
