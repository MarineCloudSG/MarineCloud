ActiveAdmin.register VesselSystem do
  belongs_to :vessel

  actions :index, :new, :create, :destroy

  # ==============
  # ==== LIST ====
  # ==============

  config.filters = false


  index do
    selectable_column
    column 'Name' do |vessel_system|
      vessel_system.system.name
    end
    column 'Code' do |vessel_system|
      vessel_system.system.code
    end
    column :created_at
    actions
  end

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :vessel_id, :system_id
end
