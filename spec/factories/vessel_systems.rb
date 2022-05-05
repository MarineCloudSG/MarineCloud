FactoryBot.define do
  factory :vessel_system do
    vessel { nil }
    system { nil }
  end

  factory :vessel_system_with_parameters_and_xls_sources, parent: :vessel_system do
    transient do
      vessel
      system
      codes { [] }
    end

    after :create do |vessel_system, evaluator|
      evaluator.codes.each do |code|
        name = code.humanize
        parameter = Parameter.find_by(name: name)
        parameter ||= create :parameter, name: name
        create :vessel_system_parameter, vessel_system: vessel_system, parameter: parameter
        create :manual_xls_parameter_source, parameter: parameter, system: vessel_system.system, code: code
      end
    end
  end
end
