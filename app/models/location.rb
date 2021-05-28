class Location < ActiveRecord::Base
  has_many :stops
  belongs_to :parent_location, class_name: 'Location', foreign_key: 'parent_id', optional: true

  def default_label
    if stops.count == 1
      stops[0].name
    else
      name = stops[0].name
      odd_stops = stops.select do |stop|
        stop.name != name
      end
      if odd_stops.count == 0
        stops[0].name
      else
        ""
      end
    end
  end

end
