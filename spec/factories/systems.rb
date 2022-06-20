FactoryBot.define do
  factory :system do
    name { Faker::Name.unique.name }
    code { Faker::Name.unique.name }
    sort_order { 10 }
  end
end
