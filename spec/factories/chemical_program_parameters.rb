FactoryBot.define do
  factory :chemical_program_parameter do
    chemical_program
    system
    parameter
    min_satisfactory { 1.5 }
    max_satisfactory { 1.5 }
  end
end
