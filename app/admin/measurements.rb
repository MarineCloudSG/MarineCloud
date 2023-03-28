ActiveAdmin.register Measurement do
  config.batch_actions = true

  filter :vessel
  filter :system
  filter :parameter
  filter :taken_at

  index do
    selectable_column
    column :id
    column :taken_at
    column :value
    column :vessel
    column :system
    column :parameter
    column :state
    actions
  end


  permit_params :value, :state

  form do |f|
    inputs "Details" do
      input :value
      input :state
    end
    actions
  end
end
