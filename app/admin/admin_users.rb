ActiveAdmin.register AdminUser do
  menu parent: 'Configuration'

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

  permit_params :email, :password, :password_confirmation

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
