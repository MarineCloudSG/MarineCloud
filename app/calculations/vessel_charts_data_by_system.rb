class VesselChartsDataBySystem < Patterns::Calculation
  private

  def result
    vessel.vessel_system_parameters
          .map { |vsp| VesselChartData.new(vsp, date_range: date_range) }
          .group_by(&:system_name)
  end

  def vessel
    options.fetch(:vessel)
  end

  def date_range
    options.fetch(:date_range)
  end
end
