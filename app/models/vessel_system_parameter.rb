class VesselSystemParameter < ApplicationRecord
  belongs_to :vessel_system
  belongs_to :parameter
  has_one :vessel, through: :vessel_system
  has_one :system, through: :vessel_system
  has_many :measurements, dependent: :delete_all

  def lowest_satisfactory_range
    overrides_satisfactory? ? min_satisfactory : parameter.min_satisfactory
  end

  def highest_satisfactory_range
    overrides_satisfactory? ? max_satisfactory : parameter.max_satisfactory
  end

  def overrides_satisfactory?
    min_satisfactory.present? || max_satisfactory.present?
  end
end
