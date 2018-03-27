FactoryBot.define do
  factory :agency do
    sequence(:name) { |n| "agency_#{n}" }
  end

  factory :route do
    sequence(:name) { |n| "route_#{n}" }
    sequence(:local_id) { |n| "#{n}" }
  end
end
