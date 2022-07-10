FactoryBot.define do
  factory :parameter_recommendation do
    chemical_provider_parameter
    value_min { nil }
    value_max { nil }
    message { "it's ok" }
  end
end
