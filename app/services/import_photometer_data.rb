# frozen_string_literal: true

class ImportPhotometerData < Patterns::Service
  class UnsupportedFileTypeError < StandardError; end

  def initialize(file:, vessel:)
    @file = file
    @vessel = vessel
  end

  def call
    raise UnsupportedFileTypeError unless supported_file_format?

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

  XLSX_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  CSV_TYPE = 'text/csv'
  SUPPORTED_TYPES = [XLSX_TYPE, CSV_TYPE]

  attr_reader :file, :vessel, :measurements_import

  def parser_results
    PhotometerDataParser.read(csv_file_path).map { |row| parser_row(row) }
  end

  def parser_row(row)
    ParsedVesselPhotometerDataRow.new(row, vessel, measurements_import)
  end

  def measurements_import
    @measurements_import ||= MeasurementsImport.create!(vessel: vessel, filename: input_file_path,
                                                        source: MeasurementsImport::PHOTOMETER_CSV_SOURCE)
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
