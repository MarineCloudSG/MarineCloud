class VesselSystemParameter < ApplicationRecord
  belongs_to :vessel_system
  belongs_to :parameter
  has_one :vessel, through: :vessel_system
  has_one :system, through: :vessel_system
  has_many :measurements, dependent: :delete_all
  has_one :chemical_provider, through: :vessel_system

  delegate :min_satisfactory, to: :chemical_provider_parameter, prefix: :default, allow_nil: true
  delegate :max_satisfactory, to: :chemical_provider_parameter, prefix: :default, allow_nil: true
  delegate :unit, to: :parameter, prefix: :default, allow_nil: true

  def lowest_satisfactory_range
    overrides_satisfactory? ? min_satisfactory : default_min_satisfactory
  end

  def highest_satisfactory_range
    overrides_satisfactory? ? max_satisfactory : default_max_satisfactory
  end

  def overrides_satisfactory?
    min_satisfactory.present? || max_satisfactory.present?
  end

  def chemical_provider_parameter
    ChemicalProviderParameter.find_by(parameter: parameter,
                                      system: vessel_system.system,
                                      chemical_provider: chemical_provider)
  end

  def recommendations
    ParameterRecommendation.where(
      chemical_provider_parameter: chemical_provider_parameter
    )
  end
end
