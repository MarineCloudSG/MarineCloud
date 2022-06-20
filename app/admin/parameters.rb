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
    column :photometer_value_multiplier
    column :sort_order
    actions
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :name, :unit, :photometer_value_multiplier, :sort_order
end
