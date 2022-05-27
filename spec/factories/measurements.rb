FactoryBot.define do
  factory :measurement do
    taken_at { DateTime.new(2020, 1, 1, 15, 00) }
    value { rand(0..100) }
    state {:in_range}
    vessel_system_parameter
    measurements_import
  end
end
