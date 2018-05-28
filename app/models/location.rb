class Location < ActiveRecord::Base
  has_many :stops
  belongs_to :parent_location, class_name: 'Location', foreign_key: 'parent_id', optional: true
end
