class AddChemicalProgramToParameterRecommendations < ActiveRecord::Migration[7.0]
  def change
    chemical_program = ChemicalProgram.last
    add_reference :parameter_recommendations, :chemical_program, null: false, foreign_key: true, default: chemical_program.id
    change_column_default :parameter_recommendations, :chemical_program_id, from: chemical_program.id, to: nil
  end
end
