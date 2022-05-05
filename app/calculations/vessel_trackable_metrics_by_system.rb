class VesselTrackableMetricsBySystem < Patterns::Calculation

  private

  def result
    vessel.vessel_system_parameters.map { |vsp| metrics(vsp) }.group_by(&:system)
  end

  def metrics(vessel_system_parameter)
    values = values(vessel_system_parameter)
    OpenStruct.new(
      name: vessel_system_parameter.parameter.name,
      system: vessel_system_parameter.system.name,
      trend: values
    )
  end

  def values(vessel_system_parameter)
    VesselSystemParameterValuesByDate.result_for(
      start_day: start_day,
      end_day: end_day,
      vessel_system_parameter: vessel_system_parameter
    )
  end

  def vessel
    options.fetch(:vessel)
  end

  def end_day
    options.fetch(:end_day)
  end

  def start_day
    options.fetch(:start_day)
  end
end
