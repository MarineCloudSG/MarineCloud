ActiveAdmin.register ParameterRecommendation do
  menu parent: 'Configuration'

  permit_params :chemical_provider_parameter_id, :value_min, :value_max, :message

  filter :chemical_provider
  filter :parameter
  filter :value_min
  filter :value_max
  filter :message
  filter :created_at
  filter :updated_at

  form do |f|
    inputs do
      input :chemical_provider_parameter, collection: ChemicalProviderParameter.all.map { |chp| ["#{chp.chemical_provider.name} -> #{chp.system.name} -> #{chp.parameter.name}", chp.id] }
      input :value_min
      input :value_max
      input :message
    end
    f.actions
  end
end
