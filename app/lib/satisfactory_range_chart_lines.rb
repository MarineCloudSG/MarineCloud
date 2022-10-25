class SatisfactoryRangeChartLines
  def initialize(max_satisfactory_range:, min_satisfactory_range:)
    @max_satisfactory_range = max_satisfactory_range
    @min_satisfactory_range = min_satisfactory_range
  end

  attr_reader :max_satisfactory_range, :min_satisfactory_range

  def chart_lines
    limits = []
    limits << highest_satisfactory_chart_line if max_satisfactory_range.present?
    limits << lowest_satisfactory_chart_line if min_satisfactory_range.present?
    limits
  end

  private

  def highest_satisfactory_chart_line
    chart_limit_line(label: 'Satisfactory max', value: max_satisfactory_range, color: '#e3a008', type: :max)
  end

  def lowest_satisfactory_chart_line
    chart_limit_line(label: 'Satisfactory min', value: min_satisfactory_range, color: '#f05252', type: :min)
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
