ActiveAdmin.register MeasurementsImport, as: "FileImports" do
  menu priority: 4, label: "Imported files"

  filter :source, as: :select, collection: MeasurementsImport::SOURCES_AVAILABLE
  filter :created_at
  filter :taken_at
  filter :vessel

  index do
    selectable_column
    id_column
    column :vessel
    column :file do |measurements_import|
      if measurements_import.file.present?
        link_to(measurements_import.file.filename, rails_blob_path(measurements_import.file, disposition: "attachment"))
      end
    end
    column :logs do |measurements_import|
      link_to("logs",  admin_import_logs_path(q: { measurements_import_id_eq: measurements_import.id }))
    end
    column :source
    column :created_at
    column :taken_at
    actions
  end
end
