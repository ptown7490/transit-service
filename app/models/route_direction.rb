class RouteDirection < ActiveRecord::Base
  belongs_to :route

  validates :direction_id, presence: true
end
