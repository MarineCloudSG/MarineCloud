ActiveAdmin.register Country do
  show do
    attributes_table do
      row :name
      row :flag do |country|
        image_tag url_for(country.flag_file)
      end
    end
  end

  permit_params :name, :flag_file

  form do |f|
    f.inputs do
      f.input :name
      f.input :flag_file
    end

    f.actions
  end
end
