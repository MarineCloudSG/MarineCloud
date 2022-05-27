ActiveAdmin.register ImportLog do
  # ==============
  # ==== LIST ====
  # ==============

  index do
    selectable_column
    column :created_at
    column :vessel
    column :msg
    actions
  end

end
