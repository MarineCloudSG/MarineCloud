ActiveAdmin.register VesselGroup do
  menu priority: 2

  # ==============
  # ==== LIST ====
  # ==============

  config.filters = false

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end

  # ==============
  # ==== SHOW ====
  # ==============

  show do
    columns do
      column do
        attributes_table title: 'Group summary' do
          row :name
        end
      end
    end

    columns do
      column do
        panel 'Vessels' do
          header_action link_to('Add vessel', new_admin_vessel_path(vessel: {vessel_group_id: vessel_group.id}))

          table_for vessel_group.vessels do
            column 'Name' do |vessel|
              link_to vessel.name, admin_vessel_path(vessel)
            end
            column :company_name
            column :email
            column :created_at
          end
        end
      end
    end
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :name, user_ids: [], vessel_ids: []

  form do |f|
    inputs do
      input :name
      input :vessels, as: :select, collection: Vessel.all
      input :users, as: :check_boxes, collection: User.pluck(:email, :id)
    end

    actions
  end
end
