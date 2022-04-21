class VesselSystem < ApplicationRecord
  belongs_to :vessel
  belongs_to :system
  has_many :vessel_system_parameters, dependent: :destroy
  has_many :parameters, through: :vessel_system_parameters
end
