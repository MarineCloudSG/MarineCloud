class VesselTrackableMetric
  def initialize(vessel_system_parameter, date_range:)
    @vessel_system_parameter = vessel_system_parameter
    @date_range = date_range
  end

  attr_reader :vessel_system_parameter, :date_range

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

  def values
    data_to_values(data)
  end

  def out_of_range_values
    data_to_values(data.reject { |row| row[1][:state].to_sym == :in_range })
  end

  private

  def data_to_values(data)
    data.map { |date, measurement| [date, measurement[:value].to_f] }
  end

  def data
    @data ||= VesselSystemParameterMeasurementsByDate.result_for(
      date_range: date_range,
      vessel_system_parameter: vessel_system_parameter
    )
  end

  def chart_limit_line(label:, value:, color:)
    OpenStruct.new(label: label, value: value.to_i, color: color)
  end

  def range
    vessel_system_parameter.satisfactory_range
  end
end
