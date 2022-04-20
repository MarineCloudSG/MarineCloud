ActiveAdmin.register VesselGroup do
  config.filters = false
  permit_params :name


  show do
    columns do
      column do
        attributes_table title: 'Group summary' do
          row :name
        end
      end
    end

    columns do
      column do
        panel 'Vessels' do
          header_action link_to('Add vessel', new_admin_vessel_path)

          table_for vessel_group.vessels do
            column 'Name' do |vessel|
              link_to vessel.name, vessel
            end
          end
        end
      end
    end
  end
end
