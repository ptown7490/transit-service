class Stop < ActiveRecord::Base
  belongs_to :agency
  has_many :stop_times

  validates :local_id, presence: true
end
