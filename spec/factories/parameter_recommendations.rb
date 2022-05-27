FactoryBot.define do
  factory :parameter_recommendation do
    parameter
    value_min { nil }
    value_max { nil }
    message { "MyString" }
  end
end
