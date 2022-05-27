class ParsedManualMeasurementDataRow
  def initialize(row, vessel)
    @row = row
    @vessel = vessel
  end

  def vessel_system_parameter
    VesselSystemParameter.joins(:parameter).where(
      'lower(parameters.name) = ?', row.fetch(:parameter).downcase).where(vessel_system: vessel_system).take!
  end

  def taken_at
    row.fetch(:taken_at)
  end

  def value
    row.fetch(:value)
  end

  private

  attr_reader :row, :vessel

  SYSTEM_NAMES_MAPPING = { 'FEED WATER' => 'FEEDWATER', 'HT CW' => 'HT COOLING', 'LT CW' => 'LT COOLING' }.freeze

  def vessel_system
    VesselSystem.find_by!(vessel: vessel, system: system)
  end

  def parameter
    vessel_system_parameter.parameter
  end

  def system
    system_name = row.fetch(:system)
    system_name = SYSTEM_NAMES_MAPPING[system_name] if SYSTEM_NAMES_MAPPING.include? system_name
    System.find_by!(name: system_name)
  end
end
