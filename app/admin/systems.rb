ActiveAdmin.register System do
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
    column :tag
    column :sort_order
    actions
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :name, :code, :sort_order, :tag
end
