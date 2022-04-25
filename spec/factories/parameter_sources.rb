FactoryBot.define do
  factory :parameter_source do
    source { ParameterSource.sources.values.sample }
    code { "MyString" }
    parameter
  end
end
