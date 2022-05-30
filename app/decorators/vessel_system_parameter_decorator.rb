class VesselSystemParameterDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{object.parameter.name} (#{object.vessel_system.system.name})"
  end

  def satisfactory_range_text
    min = object.lowest_satisfactory_range
    max = object.highest_satisfactory_range
    result ||= "#{min} => #{max}" if min.present? && max.present?
    result ||= "< #{max}" if max.present?
    result ||= "> #{min}" if min.present?

    "#{result} #{object.parameter.unit}"
  end

  def min_satisfactory
    return '-' if object.min_satisfactory.blank?

    "#{object.min_satisfactory} #{object.parameter.unit}"
  end

  def max_satisfactory
    return '-' if object.max_satisfactory.blank?

    "#{object.max_satisfactory} #{object.parameter.unit}"
  end
end
