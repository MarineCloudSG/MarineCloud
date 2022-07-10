FactoryBot.define do
  factory :chemical_provider do
    name { Faker::Name.unique.name }
  end
end
