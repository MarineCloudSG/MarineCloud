class CreateChemicalProgramParameters < ActiveRecord::Migration[7.0]
  def change
    create_table :chemical_program_parameters do |t|
      t.references :chemical_program, null: false, foreign_key: true
      t.references :system, null: false, foreign_key: true
      t.references :parameter, null: false, foreign_key: true
      t.float :min_satisfactory, null: true
      t.float :max_satisfactory, null: true

      t.timestamps
    end

    add_index :chemical_program_parameters,
              %i[chemical_program_id system_id parameter_id],
              unique: true, name: 'index_chemical_program_parameter_system'
  end
end
