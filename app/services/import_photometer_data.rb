class ImportPhotometerData < Patterns::Service
  InvalidFileFormat = Class.new(ArgumentError)

  def initialize(file:, vessel:)
    raise InvalidFileFormat unless file.content_type.eql?('text/csv')

    @filepath = file.path
    @vessel = vessel
  end

  def call
    parser_results.each do |row|
      Measurement.create!(
        vessel_system_parameter: row.vessel_system_parameter,
        parameter_source: row.parameter_source,
        taken_at: row.taken_at,
        value: row.value
      )
    end
    save_measurements_import
  end

  private

  attr_reader :filepath, :vessel

  def parser_results
    PhotometerDataParser.read(filepath).map{ |row| ParsedVesselPhotometerDataRow.new(row, vessel) }
  end

  def save_measurements_import
    MeasurementsImport.create!(vessel: vessel, filename: filepath)
  end
end
