ActiveAdmin.register ChemicalProgram do
  menu parent: 'Configuration'

  permit_params :name, chemical_program_parameters_attributes: [:id, :system_id, :parameter_id, :min_satisfactory, :max_satisfactory]

  form do |f|
    f.inputs "Details" do
      f.input :name
    end

    f.inputs "Parameters" do
      f.has_many :chemical_program_parameters do |chp|
        chp.input :system
        chp.input :parameter
        chp.input :min_satisfactory
        chp.input :max_satisfactory
      end
    end

    actions
  end
  
end
