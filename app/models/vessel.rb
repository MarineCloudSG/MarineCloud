class Vessel < ApplicationRecord
  enum chemical_program: [:marichem, :drew, :marine_care, :unitor]

  belongs_to :vessel_group, optional: true
  has_many :vessel_systems, dependent: :destroy
  has_many :systems, through: :vessel_systems
  has_many :vessel_system_parameters, through: :vessel_systems
end
