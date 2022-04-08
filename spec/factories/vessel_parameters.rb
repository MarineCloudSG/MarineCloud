FactoryBot.define do
  factory :vessel_parameter do
    vessel { nil }
    parameter { nil }
    min_satisfactory { 1.5 }
    max_satisfactory { 1.5 }
  end
end
