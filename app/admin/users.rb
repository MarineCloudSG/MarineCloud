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

  permit_params :email, :password, :password_confirmation

  form  do |f|
    inputs "Details" do
      input :email
      input :password
      input :password_confirmation
    end
    actions
  end
end
