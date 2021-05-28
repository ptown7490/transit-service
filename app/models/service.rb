class Service < ActiveRecord::Base
  belongs_to :agency
  has_many :trips
  has_many :route_directions,  -> { distinct }, through: :trips
  has_many :routes,  -> { distinct }, through: :route_directions
  has_many :stop_times, through: :trips
  has_many :blocks, -> { distinct }, through: :trips

  DAYS = [
    :sunday,
    :monday,
    :tuesday,
    :wednesday,
    :thursday,
    :friday,
    :saturday
  ]


  scope :applicable_for_day, -> (search_param) do
    if DAYS.include?(search_param)
      where(search_param => true)
    end
  end

end
