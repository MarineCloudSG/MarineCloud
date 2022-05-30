FactoryBot.define do
  factory :system do
    name { Faker::Name.unique.name }
    code { Faker::Name.unique.name }
  end
end
