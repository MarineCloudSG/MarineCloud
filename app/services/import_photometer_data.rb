# frozen_string_literal: true

class ImportPhotometerData < Patterns::Service

  def initialize(filepath:, vessel:)
    @filepath = filepath
    @vessel = vessel
  end

  def call
    parser_results.each do |row|
      Measurement.create!(
        measurements_import: measurements_import,
        vessel_system_parameter: row.vessel_system_parameter,
        taken_at: row.taken_at,
        value: row.value,
        state: row.state
      )
    end
  end

  private

  attr_reader :filepath, :vessel, :measurements_import

  def parser_results
    PhotometerDataParser.read(filepath).map { |row| parser_row(row) }
  end

  def parser_row(row)
    ParsedVesselPhotometerDataRow.new(row, vessel, measurements_import)
  end

  def measurements_import
    @measurements_import ||= MeasurementsImport.create!(vessel: vessel, filename: filepath,
                                                        source: MeasurementsImport::PHOTOMETER_CSV_SOURCE)
  end
end
