ActiveAdmin.register ImportLog do
  # ==============
  # ==== LIST ====
  # ==============

  filter :measurements_import, collection: -> {
    MeasurementsImport.all.map { |imp| [imp.vessel.name + " from " + imp.created_at.to_s, imp.id] }
  }
  filter :created_at
  filter :vessel

  index do
    selectable_column
    column :created_at
    column :vessel
    column :msg
    actions
  end

end
