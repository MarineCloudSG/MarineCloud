ActiveAdmin.register Measurement do
  config.batch_actions = true

  index do
    selectable_column
    column :id
    column :taken_at
    column :value
    column :vessel_system_parameter
    column :state
    actions
  end
end
