class ParsedVesselPhotometerDataRow
  def initialize(row, vessel)
    @row = row
    @vessel = vessel
  end

  def vessel_system_parameter
    VesselSystemParameter.find_by!(vessel_system: vessel_system, parameter: parameter_source.parameter)
  end

  def parameter_source
    ParameterSource.find_by!(
      source: ParameterSource::PHOTOMETER_CSV_SOURCE,
      code: row.fetch(:method_number)
    )
  end

  def taken_at
    row.fetch(:taken_at)
  end

  def value
    row.fetch(:value)
  end

  private

  attr_reader :row, :vessel

  def vessel_system
    VesselSystem.find_by!(vessel: vessel, system: parameter_source.system)
  end

  def parameter
    parameter_source.parameter
  end

  def system
    parameter_source.system
  end
end
