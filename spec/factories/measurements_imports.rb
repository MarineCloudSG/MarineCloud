FactoryBot.define do
  factory :measurements_import do
    vessel
    source { MeasurementsImport::PHOTOMETER_CSV_SOURCE }
    filename { "file.txt" }
  end
end
