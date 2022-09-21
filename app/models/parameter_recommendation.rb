class ParameterRecommendation < ApplicationRecord
  belongs_to :chemical_provider_parameter
  has_one :chemical_provider, through: :chemical_provider_parameter
  has_one :parameter, through: :chemical_provider_parameter

  def applies_for_value?(value)
    return false if value_min.present? && value < value_min
    return false if value_max.present? && value > value_max

    true
  end
end
