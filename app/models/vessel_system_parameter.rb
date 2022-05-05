class VesselSystemParameter < ApplicationRecord
  belongs_to :vessel_system
  belongs_to :parameter
  has_one :vessel, through: :vessel_system
  has_one :system, through: :vessel_system
  has_many :measurements
end
