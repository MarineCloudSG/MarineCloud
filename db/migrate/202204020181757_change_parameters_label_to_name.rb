class ChangeParametersLabelToName < ActiveRecord::Migration[7.0]
  def up
    if Parameter.attribute_names.include? 'label'
      rename_column :parameters, :label, :name
    end
  end

  def down; end
end
