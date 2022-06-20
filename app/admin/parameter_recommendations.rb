ActiveAdmin.register ParameterRecommendation do
  menu parent: 'Configuration'

  permit_params :chemical_program_parameter_id, :value_min, :value_max, :message

  form do |f|
    inputs do
      input :chemical_program_parameter, collection: ChemicalProgramParameter.all.map { |chp| ["#{chp.chemical_program.name} -> #{chp.system.name} -> #{chp.parameter.name}", chp.id] }
      input :value_min
      input :value_max
      input :message
    end
  end
end
