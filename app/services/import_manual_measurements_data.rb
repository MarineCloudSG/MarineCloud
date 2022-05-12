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

  XLSX_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'

  def parser_results
    ManualMeasurementsDataParser.read(filepath).fetch(:data).map { |row| ParsedManualMeasurementDataRow.new(row, vessel) }
  end

  def save_measurements_import
    MeasurementsImport.create!(vessel: vessel, filename: filepath)
  end
end
