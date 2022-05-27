ActiveAdmin.register ParameterRecommendation do
  menu parent: 'Configuration'

  permit_params :parameter_id, :value_min, :value_max, :message
end
