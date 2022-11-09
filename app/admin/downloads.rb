ActiveAdmin.register Download do
  menu parent: 'Configuration'

  permit_params :attachment, :order, :title

  index do
    selectable_column
    id_column
    column :title
    column :attachment do |download|
      if download.attachment.present?
        link_to(download.attachment.filename, rails_blob_path(download.attachment, disposition: "attachment"))
      end
    end
    column :order
    column :created_at
    column :updated_at
  end
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.input :title
    f.input :order
    f.input :attachment, :as => :file
    actions
  end
end
