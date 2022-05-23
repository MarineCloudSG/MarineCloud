class ParsedVesselPhotometerDataRow
  def initialize(row, vessel)
    @row = row
    @vessel = vessel
  end

  def vessel_system_parameter
    VesselSystemParameter.find_by!(
      vessel_system: vessel_system,
      code: row.fetch(:method_number)
    )
  end

  def taken_at
    row.fetch(:taken_at)
  end

  def state
    return :overrange if raw_value == VALUE_OVERRANGE_LABEL
    return :underrange if raw_value == VALUE_UNDERRANGE_LABEL

    :in_range
  end

  def value
    return range[:to] if raw_value == VALUE_OVERRANGE_LABEL
    return range[:from] if raw_value == VALUE_UNDERRANGE_LABEL

    raw_value.to_f
  end

  def value_in_range?
    raw_value != VALUE_UNDERRANGE_LABEL && raw_value != VALUE_OVERRANGE_LABEL
  end

  private

  VALUE_OVERRANGE_LABEL = 'Overrange'
  VALUE_UNDERRANGE_LABEL = 'Underrange'

  attr_reader :row, :vessel

  def vessel_system
    VesselSystem.find_by!(vessel: vessel, code: row.fetch(:code))
  end

  def parameter
    vessel_system_parameter.parameter
  end

  def system
    vessel_system.system
  end

  def raw_value
    row.fetch(:value)
  end

  def range
    row.fetch(:range)
  end
end
