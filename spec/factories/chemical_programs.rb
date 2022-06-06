FactoryBot.define do
  factory :chemical_program do
    name { Faker::Name.unique.name }
  end
end
