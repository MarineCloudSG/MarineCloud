class Vessel < ApplicationRecord
  enum chemical_program: [:marichem, :drew, :marine_care, :unitor]
  belongs_to :vessel_group
  has_many :vessel_parameters
end
