class RouteDirection < ActiveRecord::Base
  belongs_to :route
  has_many :trips

  validates :direction_id, presence: true
end
