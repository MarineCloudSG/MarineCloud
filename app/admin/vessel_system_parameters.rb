ActiveAdmin.register VesselSystemParameter do
  belongs_to :vessel
  decorate_with VesselSystemParameterDecorator

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
    column :default_min_satisfactory
    column "Min satisfactory override", :min_satisfactory
    column :default_max_satisfactory
    column "Max satisfactory override", :max_satisfactory
    column :code
    column 'Satisfactory range' do |vessel_system_parameter|
      vessel_system_parameter.satisfactory_range_text
    end

    actions
  end


  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :vessel_system_id, :parameter_id, :min_satisfactory, :max_satisfactory, :code

  form do |f|
    inputs "Details" do
      input :parameter_id, as: :select, collection: Parameter.all.map { |p| ["#{p.name} (#{p.unit})", p.id] }
      input :vessel_system_id, as: :select, collection: vessel.vessel_systems.map { |vs| [vs.system.name, vs.id] }
      input :min_satisfactory, label: "min satisfactory override"
      input :max_satisfactory, label: "max satisfactory override"
      input :code, hint: "code is used to match specific data row from photometer data CSV file"
      end
    actions
  end
end
