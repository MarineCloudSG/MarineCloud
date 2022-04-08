ActiveAdmin.register Vessel do

  filter :name
  filter :vessel_group

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :vessel_group_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :vessel_group_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  sidebar "Vessel Details", only: [:show, :edit] do
    ul do
      li link_to "Parameters",    admin_vessel_vessel_parameters_path(resource)
    end
  end
end
