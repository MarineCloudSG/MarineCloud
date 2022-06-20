class AssignParameterRecommendationToChemicalProgramParameter < ActiveRecord::Migration[7.0]
  def change
    add_reference :parameter_recommendations, :chemical_program_parameter, foreign_key: true, null: true, index: { name: 'index_parameter_recommendation_chp'}
    ParameterRecommendation.all.each do |rec|
      cpp = ChemicalProgramParameter.find_by(chemical_program_id: rec.chemical_program_id, parameter_id: rec.parameter_id)
      if cpp.nil?
        rec.destroy!
        next
      end

      rec.chemical_program_parameter = cpp
      rec.save!
    end
    remove_reference :parameter_recommendations, :chemical_program, foreign_key: true
    remove_reference :parameter_recommendations, :parameter, foreign_key: true
    change_column_null :parameter_recommendations, :chemical_program_parameter_id, false
  end
end
