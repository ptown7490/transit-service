class Trip < ActiveRecord::Base
  belongs_to :route_direction
  belongs_to :service
  has_many :stop_times

  has_many :stops, through: :stop_times
  has_one :route, through: :route_direction
  has_one :agency, through: :route


  def start_time
    stop_times.order(:stop_sequence).first.arrival_time
  end

end
