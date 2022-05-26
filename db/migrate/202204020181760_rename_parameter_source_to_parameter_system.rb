class RenameParameterSourceToParameterSystem < ActiveRecord::Migration[7.0]
  def change
    remove_index :measurements, :parameter_source_id
    drop_table :parameter_sources
    add_column :measurements_imports, :source, :integer
    add_column :vessel_system_parameters, :code, :string
    add_reference :measurements, :measurements_import
    add_column :vessel_systems, :code, :string
  end
end
