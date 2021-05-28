class RouteDirection < ActiveRecord::Base
  belongs_to :route
  has_one :agency, through: :route
  has_many :trips
  has_many :services,  -> { distinct }, through: :trips
  has_many :blocks, -> { distinct }, through: :trips

  validates :direction_id, presence: true

  # NOTE:
  # The following method's implementation is temporary and is based on several assumptions
  # It only works for TriMet MAX and WES services
  # The data was determined by hand using a particular seeding of the dbase,
  # => it will break if re-seeding causes analogous objects to have new ids
  def canonical_trip_id
    case id
    when 140
      1213
    when 141
      844
    when 154
      759
    when 155
      952
    when 164
      1063
    when 165
      1144
    when 170
      771
    when 171
      905
    when 172
      17
    when 173
      1
    when 176
      1234
    when 177
      1380
    else
      nil
    end
  end

  def blocks_for_service(service_id)
    block_ids = Block.joins(:trips).where("route_direction_id = #{id} AND service_id = #{service_id}").pluck("blocks.id")
    puts block_ids
    service_blocks = Block.where(id: block_ids)
  end

  def c_trip
    Trip.find(canonical_trip_id)
  end

  def stops
    stops_ids = Trip.find(canonical_trip_id).stops.select(:id).pluck(:id)
    Stop.where(id: stops_ids)
  end

  def locations
    location_ids = stops.select(:location_id).distinct('location_id').pluck(:location_id)
    Location.where(id: location_ids)
  end

  def ordered_location_ids
    StopTime.joins("INNER JOIN stops ON stop_times.stop_id = stops.id INNER JOIN locations ON stops.location_id = locations.id").where("stop_times.trip_id = #{canonical_trip_id}").select("locations.id").order("stop_times.stop_sequence").pluck("locations.id")
  end

  def service_ids
    services.order(:id).pluck(:id)
  end

end
