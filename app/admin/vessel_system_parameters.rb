ActiveAdmin.register VesselSystemParameter do
  belongs_to :vessel
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :vessel_id, :parameter_id, :min_satisfactory, :max_satisfactory
  #
  # or
  #
  # permit_params do
  #   permitted = [:vessel_id, :parameter_id, :min_satisfactory, :max_satisfactory]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form  do |f|
    inputs "Details" do
      input :parameter_id, as: :select, collection: Parameter.pluck(:label, :id)
      input :min_satisfactory
      input :max_satisfactory
      end
    actions
  end
end
