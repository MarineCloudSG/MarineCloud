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
    parser_output.fetch(:data).map { |row| ParsedManualMeasurementDataRow.new(row, vessel, measurements_import) }
  end

  def tested_by
    parser_output.fetch(:headers)[:tested_by]
  end

  def taken_at_month
    month = parser_output.fetch(:headers)[:month]
    Date.parse("01/#{month}/2022").month
  end

  def taken_at_year
    parser_output.fetch(:headers)[:year]
  end

  def taken_at
    Date.new(taken_at_year, taken_at_month, 1).end_of_month
  end

  def parser_output
    @parser_output ||= ManualMeasurementsDataParser.read(filepath)
  end

  def measurements_import
    @measurements_import ||= MeasurementsImport.create!(
      vessel: vessel,
      filename: filepath,
      source: MeasurementsImport::MANUAL_XLSX_SOURCE,
      tested_by: tested_by,
      taken_at: taken_at
    )
  end
end
