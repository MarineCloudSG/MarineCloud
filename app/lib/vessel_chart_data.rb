class VesselChartData
  def initialize(vessel_system_parameter, date_range:)
    @vessel_system_parameter = vessel_system_parameter
    @date_range = date_range
  end

  attr_reader :vessel_system_parameter, :date_range

  def name
    vessel_system_parameter.parameter.name
  end

  def system_name
    vessel_system_parameter.system.name
  end

  def satisfactory_statistics
    @satisfactory_statistics ||= SatisfactoryRangeValueDistributionForMeasurements.result_for(measurements)
  end

  def metric
    @metric ||= VesselTrackableMetric.new(vessel_system_parameter, measurements: measurements)
  end

  def measurements
    @measurements ||= VesselSystemParameterMeasurementsByDate.result_for(
      date_range: date_range,
      vessel_system_parameter: vessel_system_parameter
    )
  end

  def latest_recommendations
    @latest_recommendations ||= recommendations.select do |r|
      measurements.last.present? && r.applies_for_value?(measurements.last.value)
    end.map(&:message)
  end

  def recommendations_json
    recommendations.map { |r| { min: r.value_min, max: r.value_max, message: r.message } }.to_json
  end

  def recommendations
    @recommendations ||= vessel_system_parameter.recommendations
  end
end
