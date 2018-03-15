class Block

  def initialize(block_id, agency_id)
    @block_id = block_id
    @agency_id = agency_id
  end

  def self.all(agency_id)
    agency = Agency.find(agency_id)
    blocks = agency.trips.select(:block_id).distinct('block_id').order(:block_id)

    blocks.map do |block|
      Block.new(block.block_id, agency_id)
    end
  end

  def self.find(block_id)
    Block.new(block_id, 1)
  end

  def agency
    Agency.find(@agency_id)
  end

  def trips(service_id = nil)
    if service_id.nil?
      agency.trips.where(block_id: @block_id)
    else
      agency.trips.where(block_id: @block_id, service_id: service_id)
    end
  end

end
