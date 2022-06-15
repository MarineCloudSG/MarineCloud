FactoryBot.define do
  factory :vessel do
    name { Faker::Name.unique.name }
    email { nil }
    vessel_group
    user { nil }
    chemical_program
  end
end
