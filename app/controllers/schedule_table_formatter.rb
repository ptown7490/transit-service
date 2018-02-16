# This class handles aligning rows representing trips for table output
class ScheduleTableFormatter

  def initialize(stop_ids, trips)
    @stop_ids = stop_ids
    @stops = stop_ids.map { |stop_id| Stop.find(stop_id) }
    @trips = trips
  end

  def header
    @stops
  end

  def body
    grid = []
    @trips.each do |trip|
      row = Array.new(@stops.count, nil)  # make new row with length for all stops

      trip.stop_times.each do |stop_time|
        idx = @stop_ids.index(stop_time.stop_id)
        unless idx.nil?
          row[idx] = stop_time.arrival_time
        end
      end

      grid << { trip: trip, row: row }
    end

    RowSorting.sort(grid) do |element|
      element[:row]
    end
  end
  
end
