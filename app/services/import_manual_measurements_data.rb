# frozen_string_literal: true

class ImportManualMeasurementsData < Patterns::Service
  InvalidFileFormat = Class.new(ArgumentError)

  def initialize(file:, vessel:)
    raise InvalidFileFormat unless file.content_type.eql?(XLSX_TYPE)

    @filepath = file.path
    @vessel = vessel
  end

  def call
    parser_results.each do |row|
      Measurement.create!(
        measurements_import: measurements_import,
        vessel_system_parameter: row.vessel_system_parameter,
        taken_at: row.taken_at,
        value: row.value
      )
    end
  end

  private

  attr_reader :filepath, :vessel

  XLSX_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'

  def parser_results
    ManualMeasurementsDataParser.read(filepath).fetch(:data).map { |row| ParsedManualMeasurementDataRow.new(row, vessel, measurements_import) }
  end

  def measurements_import
    @measurements_import ||= MeasurementsImport.create!(vessel: vessel, filename: filepath, source: MeasurementsImport::MANUAL_XLSX_SOURCE)
  end
end
