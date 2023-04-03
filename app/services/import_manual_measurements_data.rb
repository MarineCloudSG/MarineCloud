# frozen_string_literal: true

class ImportManualMeasurementsData < Patterns::Service
  InvalidFileFormat = Class.new(ArgumentError)

  attr_reader :failed_rows

  def initialize(file:, vessel:)
    raise InvalidFileFormat unless file.content_type.eql?(XLSX_TYPE)

    @file = file
    @filepath = file.path
    @vessel = vessel
    @failed_rows = 0
  end

  def call
    parser_results.each do |row|
      save_result_row(row)
    end
  end

  private

  attr_reader :file, :filepath, :vessel

  XLSX_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'

  def save_result_row(row)
    Measurement.create!(
      measurements_import: measurements_import,
      vessel_system_parameter: row.vessel_system_parameter,
      taken_at: row.taken_at,
      value: row.value,
      state: row.state
    )
  rescue => exception
    Sentry.capture_exception(exception)
    @failed_rows += 1
  end

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
    Date.new(taken_at_year.to_i, taken_at_month.to_i, 1).end_of_month
  end

  def parser_output
    @parser_output ||= ManualMeasurementsDataParser.read(filepath)
  end

  def measurements_import
    @measurements_import ||= MeasurementsImport.create!(
      vessel: vessel,
      filename: filepath,
      file: file,
      source: MeasurementsImport::MANUAL_XLSX_SOURCE,
      tested_by: tested_by,
      taken_at: taken_at
    )
  end
end
