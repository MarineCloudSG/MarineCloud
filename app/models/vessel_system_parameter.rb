class VesselSystemParameter < ApplicationRecord
  belongs_to :vessel_system
  belongs_to :parameter
  has_one :vessel, through: :vessel_system
  has_one :system, through: :vessel_system
  has_many :measurements, dependent: :delete_all
  has_one :chemical_program, through: :vessel_system

  def lowest_satisfactory_range
    overrides_satisfactory? ? min_satisfactory : default_min_satisfactory
  end

  def highest_satisfactory_range
    overrides_satisfactory? ? max_satisfactory : default_max_satisfactory
  end

  def overrides_satisfactory?
    min_satisfactory.present? || max_satisfactory.present?
  end

  def chemical_program_parameter
    ChemicalProgramParameter.find_by(parameter: parameter,
                                     system: vessel_system.system,
                                     chemical_program: chemical_program)
  end

  def default_min_satisfactory
    chemical_program_parameter&.min_satisfactory
  end

  def default_max_satisfactory
    chemical_program_parameter&.max_satisfactory
  end
end
