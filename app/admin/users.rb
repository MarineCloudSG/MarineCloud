ActiveAdmin.register User do
  menu priority: 3

  # ==============
  # ==== LIST ====
  # ==============

  filter :email

  index do
    selectable_column
    id_column
    column :email
    actions
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :email, :password, :password_confirmation, vessel_group_ids: []

  form do |f|
    inputs "Details" do
      input :email
      input :password
      input :password_confirmation
      input :vessel_groups, as: :check_boxes, collection: VesselGroup.all
    end
    actions
  end

  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

end
