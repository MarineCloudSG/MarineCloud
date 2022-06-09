class VesselSystem < ApplicationRecord
  belongs_to :vessel
  belongs_to :system
  has_many :vessel_system_parameters, dependent: :destroy
  has_many :parameters, through: :vessel_system_parameters
  has_one :chemical_program, through: :vessel
  has_many :chemical_program_parameters, through: :chemical_program

  accepts_nested_attributes_for :vessel_system_parameters
end
