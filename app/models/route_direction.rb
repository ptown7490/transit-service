class RouteDirection < ActiveRecord::Base
  belongs_to :route
  has_one :agency, through: :route
  has_many :trips
  has_many :services,  -> { distinct }, through: :trips

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

  def service_ids
    Trip.where(route_direction_id: self.id).select(:service_id).distinct('service_id').order(:service_id).map do |record|
      record.service_id
    end
  end
end
