ActiveAdmin.register Vessel do
  filter :name
  filter :vessel_group

  permit_params :name, :vessel_group_id, :company_name, :email, :chemical_program

  form do |f|
    f.inputs do
      f.input :name
      f.input :vessel_group
      f.input :company_name
      f.input :email
      f.input :chemical_program, collection: Vessel.chemical_programs
    end
    f.actions
  end


  sidebar "Vessel Details", only: [:show, :edit] do
    ul do
      li link_to "Parameters", admin_vessel_vessel_parameters_path(resource)
    end
  end
end
