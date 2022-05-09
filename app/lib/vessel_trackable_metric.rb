class VesselTrackableMetric
  def initialize(vessel_system_parameter, start_date:, end_date:)
    @vessel_system_parameter = vessel_system_parameter
    @start_date = start_date
    @end_date = end_date
  end

  def name
    vessel_system_parameter.parameter.name
  end

  def system
    vessel_system_parameter.system.name
  end

  def satisfactory_range_limits
    limits = []
    limits << chart_limit_line(label: 'Satisfactory max', value: range[1], color: '#00ff00') if range[1].present?
    limits << chart_limit_line(label: 'Satisfactory min', value: range[0], color: '#ff0000') if range[0].present?
  end

  def data
    VesselSystemParameterValuesByDate.result_for(
      start_day: start_date,
      end_day: end_date,
      vessel_system_parameter: vessel_system_parameter
    )
  end

  private

  attr_reader :vessel_system_parameter, :start_date, :end_date

  def chart_limit_line(label:, value:, color:)
    OpenStruct.new(label: label, value: value.to_i, color: color)
  end

  def range
    vessel_system_parameter.satisfactory_range
  end
end
