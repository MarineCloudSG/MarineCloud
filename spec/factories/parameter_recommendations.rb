FactoryBot.define do
  factory :parameter_recommendation do
    parameter
    chemical_program
    value_min { nil }
    value_max { nil }
    message { "it's ok" }
  end
end
