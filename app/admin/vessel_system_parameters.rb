ActiveAdmin.register VesselSystemParameter do
  belongs_to :vessel

  actions :index, :new, :create, :edit, :update, :destroy

  # ==============
  # ==== LIST ====
  # ==============

  config.filters = false

  index do
    selectable_column
    column 'Parameter' do |vessel_system_parameter|
      vessel_system_parameter.parameter.name
    end
    column 'System' do |vessel_system_parameter|
      vessel_system_parameter.vessel_system.system.name
    end
    column :min_satisfactory
    column :max_satisfactory

    actions
  end


  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :vessel_system_id, :parameter_id, :min_satisfactory, :max_satisfactory

  form do |f|
    inputs "Details" do
      input :parameter_id, as: :select, collection: Parameter.all.map { |p| ["#{p.name} (#{p.unit})", p.id] }
      input :vessel_system_id, as: :select, collection: vessel.vessel_systems.map { |vs| [vs.system.name, vs.id] }
      input :min_satisfactory
      input :max_satisfactory
      end
    actions
  end
end
