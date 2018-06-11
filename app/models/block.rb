class Block < ActiveRecord::Base
  belongs_to :agency
  has_many :trips
  has_many :services, -> { distinct }, through: :trips

  validates :local_id, presence: true


end
