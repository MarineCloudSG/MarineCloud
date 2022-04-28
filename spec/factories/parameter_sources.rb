FactoryBot.define do
  factory :parameter_source do
    source { ParameterSource.sources.values.sample }
    code { "MyString" }
    parameter
  end

  factory :photometer_csv_parameter_source, parent: :parameter_source do
    source { ParameterSource::PHOTOMETER_CSV_SOURCE }
    code { rand(0..600) }
  end

  factory :manual_xls_parameter_source, parent: :parameter_source do
    source { ParameterSource::MANUAL_XLSX_SOURCE }
  end
end
