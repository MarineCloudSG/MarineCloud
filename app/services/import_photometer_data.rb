# frozen_string_literal: true

class ImportPhotometerData < Patterns::Service
  class UnsupportedFileTypeError < StandardError; end

  attr_reader :failed_rows

  def initialize(file:, vessel:)
    @file = file
    @vessel = vessel
    @failed_rows = 0
  end

  def call
    raise UnsupportedFileTypeError unless supported_file_format?

    parser_results.each do |row|
      save_result_row(row)
    end
  end

  private

  XLSX_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  CSV_TYPE = 'text/csv'
  SUPPORTED_TYPES = [XLSX_TYPE, CSV_TYPE]

  attr_reader :file, :vessel, :measurements_import

  def save_result_row(row)
    Measurement.create!(
      measurements_import: measurements_import,
      vessel_system_parameter: row.vessel_system_parameter,
      taken_at: row.taken_at,
      value: adjusted_row_value(row),
      state: row.state
    )
  rescue
    @failed_rows += 1
  end

  def adjusted_row_value(row)
    row.value * row_multiplier(row)
  end

  def row_multiplier(row)
    row.vessel_system_parameter.parameter.photometer_value_multiplier
  end

  def parser_results
    PhotometerDataParser.read(csv_file_path).map { |row| parser_row(row) }
  end

  def parser_row(row)
    ParsedVesselPhotometerDataRow.new(row, vessel, measurements_import)
  end

  def measurements_import
    @measurements_import ||= MeasurementsImport.create!(vessel: vessel,
                                                        filename: input_file_path,
                                                        file: file,
                                                        source: MeasurementsImport::PHOTOMETER_CSV_SOURCE
    )
  end

  def csv_file_path
    return ConvertXlsxToCsv.call(input_file_path).result if xlsx?

    input_file_path
  end

  def xlsx?
    file_type.eql?(XLSX_TYPE)
  end

  def supported_file_format?
    SUPPORTED_TYPES.include?(file_type)
  end

  def file_type
    file.content_type
  end

  def input_file_path
    file.path
  end
end
