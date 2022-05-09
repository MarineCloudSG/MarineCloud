class VesselTrackableMetricsBySystem < Patterns::Calculation
  private

  def result
    vessel.vessel_system_parameters
          .map { |vsp| metric(vsp) }
          .group_by(&:system)
  end

  def metric(vessel_system_parameters)
    VesselTrackableMetric.new(vessel_system_parameters, date_range: date_range)
  end

  def vessel
    options.fetch(:vessel)
  end

  def date_range
    options.fetch(:date_range)
  end
end
