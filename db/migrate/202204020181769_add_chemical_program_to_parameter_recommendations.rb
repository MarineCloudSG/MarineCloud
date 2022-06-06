class AddChemicalProgramToParameterRecommendations < ActiveRecord::Migration[7.0]
  def change
    add_reference :parameter_recommendations, :chemical_program, null: false, foreign_key: true
  end
end
