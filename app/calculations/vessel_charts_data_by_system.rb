class VesselChartsDataBySystem < Patterns::Calculation
  private

  def result
    vessel_system_parameters
      .map { |vsp| VesselChartData.new(vsp, date_range: date_range) }
      .group_by(&:system_name)
  end

  def vessel_system_parameters
    params = vessel.vessel_system_parameters
                   .joins(:system, :parameter)
                   .order('system.sort_order': :ASC, 'parameter.sort_order': :ASC)
    params = params.where(parameter_id: parameter_ids)
    params = params.where(vessel_systems: { systems: system }) if system.present?
    params
  end

  def vessel
    options.fetch(:vessel)
  end

  def date_range
    options.fetch(:date_range)
  end

  def system
    options[:system]
  end

  def parameter_ids
    options.fetch(:parameter_ids)
  end
end
