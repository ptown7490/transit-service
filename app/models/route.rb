class Route < ActiveRecord::Base
  belongs_to :agency

  validates :local_id, presence: true
  validates :name, presence: true
end
