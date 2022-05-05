ActiveAdmin.register ParameterSource do
  menu parent: 'Configuration'

  # ==============
  # ==== LIST ====
  # ==============

  filter :name

  index do
    selectable_column
    id_column
    column :source
    column :code
    column :parameter
    column :system
    actions
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :source, :code, :parameter, :system
end
