class VesselSystem < ApplicationRecord
  belongs_to :vessel
  belongs_to :system
  has_many :vessel_system_parameters, dependent: :destroy
  has_many :parameters, through: :vessel_system_parameters
  has_one :chemical_provider, through: :vessel
  has_many :chemical_provider_parameters, through: :chemical_provider

  accepts_nested_attributes_for :vessel_system_parameters

  delegate :name, to: :system
  delegate :code, to: :system, prefix: :default
end
