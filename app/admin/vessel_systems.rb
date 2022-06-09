ActiveAdmin.register VesselSystem do
  belongs_to :vessel

  # actions :index, :new, :create, :destroy, :edit

  # ==============
  # ==== LIST ====
  # ==============

  config.filters = false


  index do
    selectable_column
    column 'Name' do |vessel_system|
      vessel_system.system.name
    end
    column :default_code
    column 'Code override', :code
    column :created_at
    actions
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :vessel_id, :system_id, :code
   form do |f|
    f.inputs do
      f.input :system
      f.input :code
    end
    f.actions
  end
end
