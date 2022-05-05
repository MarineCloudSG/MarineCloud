class Vessel < ApplicationRecord
  enum chemical_program: [:marichem, :drew, :marine_care, :unitor]

  belongs_to :vessel_group, optional: true
  belongs_to :user, optional: true
  has_many :vessel_systems, dependent: :destroy
  has_many :systems, through: :vessel_systems
  has_many :vessel_system_parameters, through: :vessel_systems
  has_many :parameters, through: :vessel_system_parameters
  has_many :measurements, through: :vessel_system_parameters
  has_many :measurements_imports

  def last_data_upload
    measurements_imports.maximum(:created_at)
  end
end
