FactoryBot.define do
  factory :country do
    name { Faker::Name.unique.name }
  end
end
