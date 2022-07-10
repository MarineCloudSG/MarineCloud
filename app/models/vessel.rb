class Vessel < ApplicationRecord
  belongs_to :vessel_group, optional: true
  belongs_to :user, optional: true
  belongs_to :chemical_provider
  has_many :vessel_systems, dependent: :destroy
  has_many :systems, through: :vessel_systems
  has_many :vessel_system_parameters, through: :vessel_systems
  has_many :parameters, through: :vessel_system_parameters
  has_many :measurements, through: :vessel_system_parameters
  has_many :measurements_imports, dependent: :delete_all
  has_many :comments, class_name: VesselComment.name

  accepts_nested_attributes_for :vessel_systems

  def last_data_upload
    measurements_imports.maximum(:created_at)
  end

  def last_tested_by
    measurements_imports.where(source: MeasurementsImport::MANUAL_XLSX_SOURCE)
                        .order(created_at: :ASC)
                        .last&.tested_by
  end
end
