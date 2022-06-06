class AddChemicalProgramToVessels < ActiveRecord::Migration[7.0]
  def change
    chemical_program = ChemicalProgram.find_or_create_by!(name: 'drew')
    remove_column :vessels, :chemical_program, :integer
    add_reference :vessels, :chemical_program, null: false, foreign_key: true, default: chemical_program.id
    change_column_default :vessels, :chemical_program_id, from: chemical_program.id, to: nil
  end
end
