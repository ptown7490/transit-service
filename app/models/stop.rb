class Stop < ActiveRecord::Base
  belongs_to :agency

  validates :local_id, presence: true
end
