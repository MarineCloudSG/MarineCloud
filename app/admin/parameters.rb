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
    column :unit
    column :sort_order
    actions
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :name, :unit, :sort_order
end
