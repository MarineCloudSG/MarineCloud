class VesselTrackableMetric
  def initialize(vessel_system_parameter, measurements:)
    @vessel_system_parameter = vessel_system_parameter
    @measurements = measurements
  end

  attr_reader :vessel_system_parameter, :measurements

  def satisfactory_range_limits
    SatisfactoryRangeChartLines.new(max_satisfactory_range: highest_satisfactory_range, min_satisfactory_range: lowest_satisfactory_range).chart_lines
  end

  def values
    measurements.map { |m| [m.taken_at.to_date.to_time(:utc), m.value.to_f] }
  end

  def out_of_range_values
    measurements.reject { |row| row.state.to_sym == :in_range }.map do |m|
      [m.taken_at.to_date, { value: m.value.to_f, state: m.state.to_sym }]
    end
  end

  def chart_range_min
    chart_all_values.min
  end

  def chart_range_max
    chart_all_values.max
  end

  private

  def chart_all_values
    @chart_all_values ||= (chart_numeric_values + [lowest_satisfactory_range, highest_satisfactory_range]).compact
  end

  def chart_numeric_values
    values.map { |_date, value| value }
  end

  def highest_satisfactory_chart_line
    chart_limit_line(label: 'Satisfactory max', value: highest_satisfactory_range, color: '#e3a008', type: :max)
  end

  def lowest_satisfactory_chart_line
    chart_limit_line(label: 'Satisfactory min', value: lowest_satisfactory_range, color: '#f05252', type: :min)
  end

  def chart_limit_line(label:, value:, color:, type:)
    OpenStruct.new(label: label, value: value, color: color, type: type)
  end

  def lowest_satisfactory_range
    vessel_system_parameter.lowest_satisfactory_range
  end

  def highest_satisfactory_range
    vessel_system_parameter.highest_satisfactory_range
  end
end
