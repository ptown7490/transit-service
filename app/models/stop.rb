class Stop < ActiveRecord::Base
  belongs_to :agency
  has_many :stop_times
  belongs_to :parent_station, class_name: 'Stop', foreign_key: 'parent_station_id', optional: true
  has_many :children, class_name: 'Stop', foreign_key: 'parent_station_id', inverse_of: :parent_station

  validates :local_id, presence: true

  def self.related(stop_a, stop_b)
    result = (
      (stop_a == stop_b) ||
      (
        ! (stop_a.parent_station.nil? || stop_b.parent_station.nil?) &&
        stop_a.parent_station == stop_b.parent_station
      ) ||
      (stop_a.parent_station == stop_b) ||
      (stop_b.parent_station == stop_a)
    )

    result
  end
end
