class ParsedVesselPhotometerDataRow
  class HandledImportException < StandardError; end
  def initialize(row, vessel, import)
    @row = row
    @vessel = vessel
    @import = import
  end

  def vessel_system_parameter
    parameter_code = row.fetch(:method_number)
    begin
      VesselSystemParameter.find_by!(
        vessel_system: vessel_system,
        code: parameter_code
      )
    rescue ActiveRecord::RecordNotFound
      ImportLog.create(measurements_import: import, msg: "missing assigment of parameter with code #{parameter_code} from system #{vessel_system.system.name}", vessel: vessel)
      raise HandledImportException
    end
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

  attr_reader :row, :vessel, :import

  def vessel_system
    system_code = row.fetch(:code)
    begin
      VesselSystem.find_by!(vessel: vessel, code: system_code)
    rescue ActiveRecord::RecordNotFound
      begin
        VesselSystem.joins(:system).find_by!(vessel: vessel, systems: { code: system_code })
      rescue ActiveRecord::RecordNotFound
        ImportLog.create(measurements_import: import, msg: "missing assigment system by code #{system_code}", vessel: vessel)
        raise HandledImportException
      end
    end
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
