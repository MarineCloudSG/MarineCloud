FactoryBot.define do
  factory :vessel do
    name { Faker::Name.unique.name }
    vessel_group
    user { nil }
  end
end
