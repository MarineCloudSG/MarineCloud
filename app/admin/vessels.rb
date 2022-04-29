ActiveAdmin.register Vessel do
  menu priority: 1
  decorate_with VesselDecorator

  # ==============
  # ==== LIST ====
  # ==============

  filter :name
  filter :vessel_group

  index do
    selectable_column
    column 'Name' do |vessel|
      link_to vessel.name, admin_vessel_path(vessel)
    end
    column :vessel_group
    column :company_name
    column :created_at
    actions
  end

  # ==============
  # ==== SHOW ====
  # ==============


  show do
    columns do
      column do
        attributes_table title: 'Vessel' do
          row :name
          row :vessel_group
          row :company_name
          row :email
          row :chemical_program
          row :last_data_upload
          row 'Managed by' do
            vessel.user
          end
        end

        panel 'Systems' do
          header_action link_to('Manage systems', admin_vessel_vessel_systems_path(vessel))

          table_for vessel.systems do
            column :name
            column :code
          end
        end
      end

      column do
        panel 'Parameters' do
          header_action link_to('Manage parameters', admin_vessel_vessel_system_parameters_path(vessel))

          table_for vessel.vessel_system_parameters do
            column 'Name' do |vessel_system_parameter|
              link_to vessel_system_parameter.name, edit_admin_vessel_vessel_system_parameter_path(vessel, vessel_system_parameter)
            end
            column :min_satisfactory
            column :max_satisfactory
          end
        end
      end
    end
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :name, :vessel_group_id, :company_name, :email, :chemical_program, :user_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :vessel_group
      f.input :company_name
      f.input :email
      f.input :chemical_program, collection: Vessel.chemical_programs.map{|name, _id| [name.humanize, name]}
      f.input :user, label: 'Managed by', collection: User.pluck(:email, :id)
    end
    f.actions
  end
end
