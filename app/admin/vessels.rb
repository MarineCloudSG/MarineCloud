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
          row :chemical_provider
          row :last_data_upload
          row 'Managed by' do
            vessel.user
          end
          row :country
        end

        panel 'Systems' do
          header_action link_to('Manage systems', admin_vessel_vessel_systems_path(vessel))

          table_for vessel.vessel_systems do
            column :name
            column :default_code
            column 'Code override', :code
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
            column :default_min_satisfactory
            column "Min satisfactory override", :min_satisfactory
            column :default_max_satisfactory
            column "Max satisfactory override", :max_satisfactory
          end
        end
      end
    end
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :name,
                :vessel_group_id,
                :company_name,
                :email,
                :chemical_provider_id,
                :user_id,
                :country_id,
                vessel_systems_attributes: [
                  :id,
                  :system_id,
                  :code,
                  vessel_system_parameters_attributes: [
                    :id,
                    :parameter_id,
                    :code,
                    :min_satisfactory,
                    :max_satisfactory
                  ]
                ]

  form do |f|
    f.inputs do
      f.input :name
      f.input :vessel_group
      f.input :company_name
      f.input :email
      f.input :chemical_provider
      f.input :user, label: 'Managed by', collection: User.pluck(:email, :id)
      f.input :country
    end
    f.inputs "Assigned systems" do
      f.has_many :vessel_systems, allow_destroy: true do |vs|
        vs.input :system
        vs.input :code, label: "Code override"
        vs.has_many :vessel_system_parameters, allow_destroy: true do |vsp|
          vsp.inputs "Assigned parameters" do
          vsp.input :parameter
          vsp.input :code
          vsp.input :min_satisfactory, label: "Min satisfactory override"
          vsp.input :max_satisfactory, label: "Max satisfactory override"
        end
        end
      end
    end

    f.actions
  end
end
