class ChemicalProgram < ApplicationRecord
  has_many :chemical_program_parameters

  accepts_nested_attributes_for :chemical_program_parameters
end
