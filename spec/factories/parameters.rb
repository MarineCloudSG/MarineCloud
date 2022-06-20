FactoryBot.define do
  factory :parameter do
    name { "MyString" }
    photometer_value_multiplier { 1 }
    sort_order { 10 }
  end
end
