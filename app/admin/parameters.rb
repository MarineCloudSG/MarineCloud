ActiveAdmin.register Parameter do
  menu parent: 'Configuration'

  # ==============
  # ==== LIST ====
  # ==============

  filter :name

  index do
    selectable_column
    id_column
    column :name
    column :code
    column :unit
    column :min_satisfactory
    column :max_satisfactory
    actions
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :name, :code, :unit, :min_satisfactory, :max_satisfactory
end
