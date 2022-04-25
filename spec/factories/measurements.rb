FactoryBot.define do
  factory :measurement do
    datetime { "2022-04-25 18:57:13" }
    parameter { nil }
    measurement_method
    value { 1.5 }
  end
end
