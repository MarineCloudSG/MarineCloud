class VesselSystemParameter < ApplicationRecord
  belongs_to :vessel_system
  belongs_to :parameter
  has_one :vessel, through: :vessel_system
  has_one :system, through: :vessel_system
  has_many :measurements, dependent: :delete_all

  def satisfactory_range
    return [min_satisfactory, max_satisfactory] if min_satisfactory.present? || max_satisfactory.present?

    [parameter.min_satisfactory, parameter.max_satisfactory]
  end
end
