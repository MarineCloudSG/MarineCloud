class ParameterRecommendation < ApplicationRecord
  belongs_to :parameter
  belongs_to :chemical_program

  def applies_for_value?(value)
    return false if value_min.present? && value < value_min
    return false if value_max.present? && value > value_max

    true
  end
end
