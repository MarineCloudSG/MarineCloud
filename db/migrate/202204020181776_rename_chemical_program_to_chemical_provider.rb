class RenameChemicalProgramToChemicalProvider < ActiveRecord::Migration[7.0]
  def change
    rename_table :chemical_programs, :chemical_providers
    rename_table :chemical_program_parameters, :chemical_provider_parameters
    rename_column :chemical_provider_parameters, :chemical_program_id, :chemical_provider_id
    rename_column :vessels, :chemical_program_id, :chemical_provider_id
    rename_column :parameter_recommendations, :chemical_program_parameter_id, :chemical_provider_parameter_id
    rename_index :chemical_provider_parameters, "index_chemical_program_parameter_system", "index_chemical_provider_parameter_system"
  end
end
