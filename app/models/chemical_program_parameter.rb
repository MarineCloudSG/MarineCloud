class ChemicalProgramParameter < ApplicationRecord
  belongs_to :chemical_program
  belongs_to :system
  belongs_to :parameter
end
