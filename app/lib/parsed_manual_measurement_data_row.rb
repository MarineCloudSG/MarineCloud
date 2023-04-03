class ParsedManualMeasurementDataRow

  VALUE_OVERRANGE_LABELS = ['overrange', 'overange', 'over']
  VALUE_UNDERRANGE_LABELS = ['underrange', 'underange', 'under']

  class HandledImportException < StandardError; end

  def initialize(row, vessel, import)
    @row = row
    @vessel = vessel
    @import = import
  end

  def vessel_system_parameter
    parameter_name = row.fetch(:parameter)
    begin
      VesselSystemParameter.joins(:parameter).where(
        'lower(parameters.name) = ?', parameter_name.downcase).where(
        vessel_system: vessel_system).take!
    rescue ActiveRecord::RecordNotFound
      ImportLog.create(measurements_import: import, msg: "missing assigment of parameter #{parameter_name} from system #{vessel_system.system.name}", vessel: vessel)
      raise HandledImportException
    end
  end

  def taken_at
    row.fetch(:taken_at)
  end

  def state
    value = raw_value.to_s
    return :overrange if VALUE_OVERRANGE_LABELS.include?(value.downcase)
    return :underrange if VALUE_UNDERRANGE_LABELS.include?(value.downcase)

    :in_range
  end

  def raw_value
    row.fetch(:value)
  end

  def value
    if state.to_sym != :in_range
      return nil
    end
    value = raw_value
    if value
      value = value.to_s.sub(",", ".")
    end
    value&.to_f
  end

  private

  attr_reader :row, :vessel, :import

  SYSTEM_NAMES_MAPPING = { 'FEED WATER' => 'FEEDWATER', 'HT CW' => 'HT COOLING', 'LT CW' => 'LT COOLING' }.freeze

  def vessel_system
    VesselSystem.find_by!(vessel: vessel, system: system)
  rescue ActiveRecord::RecordNotFound
    ImportLog.create(measurements_import: import, msg: "missing assigment system #{system.name}", vessel: vessel)
    raise HandledImportException
  end

  def parameter
    vessel_system_parameter.parameter
  end

  def system
    system_name = row.fetch(:system)
    system_name = SYSTEM_NAMES_MAPPING[system_name] if SYSTEM_NAMES_MAPPING.include? system_name
    begin
      System.find_by!(name: system_name)
    rescue ActiveRecord::RecordNotFound
      ImportLog.create(measurements_import: import, msg: "missing system #{system_name}", vessel: vessel)
      raise HandledImportException
    end
  end
end
