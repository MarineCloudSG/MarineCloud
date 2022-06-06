class AddChemicalProgramToVessels < ActiveRecord::Migration[7.0]
  def change
    add_reference :vessels, :chemical_program, null: false, foreign_key: true
  end
end
