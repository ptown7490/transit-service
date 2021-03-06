class Trip < ActiveRecord::Base
  belongs_to :route_direction
  belongs_to :service
  belongs_to :block
  has_many :stop_times

  has_many :stops, through: :stop_times
  has_one :route, through: :route_direction
  has_one :agency, through: :route

  def ordered_stop_times
    stop_times.order(:stop_sequence)
  end

  def ordered_stops
    stops.order("stop_times.stop_sequence")
  end

  def start_time
    stop_times.order(:stop_sequence).first.arrival_time
  end

  def start_stop
    stop_times.order(:stop_sequence).first.stop
  end

  def end_time
    stop_times.order(:stop_sequence).last.arrival_time
  end

  def end_stop
    stop_times.order(:stop_sequence).last.stop
  end

end
