class Block

  def initialize(block_id, agency_id)
    @block_id = block_id
    @agency_id = agency_id
  end

  attr_reader :block_id, :agency_id

  def self.all(agency_id)
    agency = Agency.find(agency_id)
    blocks = agency.trips.select(:block_id).distinct('block_id').order(:block_id)

    blocks.map do |block|
      Block.new(block.block_id, agency_id)
    end
  end

  def self.find(block_id, agency_id = 1)
    Block.new(block_id, agency_id)
  end

  def agency
    Agency.find(@agency_id)
  end

  def trips(service_id = nil)
    if service_id.nil?
      agency.trips.where(block_id: @block_id).sort_by(&:start_time)
    else
      agency.trips.where(block_id: @block_id, service_id: service_id).sort_by(&:start_time)
    end
  end

  def services
    agency.trips.where(block_id: @block_id).select(:service_id).distinct('service_id').order(:service_id)
  end

end
