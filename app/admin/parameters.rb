ActiveAdmin.register Parameter do
  menu parent: 'Configuration'

  # ==============
  # ==== LIST ====
  # ==============

  filter :label

  index do
    selectable_column
    id_column
    column :label
    column :code
    column :unit
    actions
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :label, :code, :unit
end
