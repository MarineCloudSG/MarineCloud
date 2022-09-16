class VesselTrackableMetric
  def initialize(vessel_system_parameter, measurements:)
    @vessel_system_parameter = vessel_system_parameter
    @measurements = measurements
  end

  attr_reader :vessel_system_parameter, :measurements

  def satisfactory_range_limits
    limits = []
    limits << highest_satisfactory_chart_line if highest_satisfactory_range.present?
    limits << lowest_satisfactory_chart_line if lowest_satisfactory_range.present?
    limits
  end

  def values
    measurements.map { |m| [m.taken_at.to_date, m.value.to_f] }
  end

  def out_of_range_values
    measurements.reject { |row| row.state.to_sym == :in_range }.map do |m|
      [m.taken_at.to_date, { value: m.value.to_f, state: m.state.to_sym }]
    end
  end

  def chart_range_min
    (chart_numeric_values + [lowest_satisfactory_range]).compact.min
  end

  def chart_range_max
    (chart_numeric_values + [highest_satisfactory_range]).compact.max
  end

  private

  def chart_numeric_values
    values.map { |_date, value| value }
  end

  def highest_satisfactory_chart_line
    chart_limit_line(label: 'Satisfactory max', value: highest_satisfactory_range, color: '#00ff00', type: :max)
  end

  def lowest_satisfactory_chart_line
    chart_limit_line(label: 'Satisfactory min', value: lowest_satisfactory_range, color: '#ff0000', type: :min)
  end

  def chart_limit_line(label:, value:, color:, type:)
    OpenStruct.new(label: label, value: value.to_i, color: color, type: type)
  end

  def lowest_satisfactory_range
    vessel_system_parameter.lowest_satisfactory_range
  end

  def highest_satisfactory_range
    vessel_system_parameter.highest_satisfactory_range
  end
end
