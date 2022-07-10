FactoryBot.define do
  factory :chemical_provider_parameter do
    chemical_provider
    system
    parameter
    min_satisfactory { 1.5 }
    max_satisfactory { 1.5 }
  end
end
