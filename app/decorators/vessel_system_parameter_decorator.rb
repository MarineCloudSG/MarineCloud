class VesselSystemParameterDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{object.parameter.name} (#{object.vessel_system.system.name})"
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
