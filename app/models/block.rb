class Block < ActiveRecord::Base
  belongs_to :agency
  has_many :trips
  has_many :services, -> { distinct }, through: :trips

  validates :local_id, presence: true

  def ordered_trips_for_service(service_id)
    trips.where(service_id: service_id).sort_by(&:start_time)
  end

  def self.number_of_services(number)
    blocks = self.all.to_a
    blocks.keep_if { |block| block.services.count == number }
  end

  scope :search_by_service, -> (service_id) do
    joins(:trips).where(trips: { service_id: service_id }).select('blocks.*').distinct
    # joins(:trips).where(trips: { service_id: service_id }).group('blocks.id')
  end

  # collect service_counts for each block_id
  def self.service_counts
    sql = %Q{
      SELECT
        blocks.*,
        COUNT(DISTINCT trips.service_id) AS num_services
      FROM
        blocks
          INNER JOIN
        trips
          ON trips.block_id = blocks.id
      GROUP BY blocks.id
      ORDER BY blocks.id;
    }

    Block.connection.select_all(sql).to_hash
  end


  # def initialize(block_id, agency_id)
  #   @block_id = block_id
  #   @agency_id = agency_id
  # end
  #
  # attr_reader :block_id, :agency_id
  #
  # def self.all(agency_id)
  #   agency = Agency.find(agency_id)
  #   blocks = agency.trips.select(:block_id).distinct('block_id').order(:block_id)
  #
  #   blocks.map do |block|
  #     Block.new(block.block_id, agency_id)
  #   end
  # end
  #
  # def self.find(block_id, agency_id)
  #   Block.new(block_id, agency_id)
  # end
  #
  # def agency
  #   Agency.find(@agency_id)
  # end
  #
  # def trips(service_id = nil)
  #   if service_id.nil?
  #     agency.trips.where(block_id: @block_id)
  #   else
  #     agency.trips.where(block_id: @block_id, service_id: service_id)
  #   end
  # end
  #
  # def services
  #   agency.trips.where(block_id: @block_id).select(:service_id).distinct('service_id').map do |trip|
  #     Service.find(trip.service_id)
  #   end
  # end


end
