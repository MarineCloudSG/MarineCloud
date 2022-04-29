FactoryBot.define do
  factory :measurements_import do
    vessel
    filename { "file.txt" }
  end
end
