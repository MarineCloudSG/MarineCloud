class VesselTrackableMetricsBySystem < Patterns::Calculation

  private

  def result
    vessel.vessel_system_parameters
          .map { |vsp| metric(vsp) }
          .group_by(&:system)
  end

  def metric(vessel_system_parameters)
    VesselTrackableMetric.new(vessel_system_parameters, start_date: start_date, end_date: end_date)
  end

  def vessel
    options.fetch(:vessel)
  end

  def end_date
    options.fetch(:end_date)
  end

  def start_date
    options.fetch(:start_date)
  end
end
