# frozen_string_literal: true

class ManualMeasurementsDataParser
  class InvalidDate < StandardError; end

  def self.read(*args)
    new(*args).result
  end

  attr_reader :data, :headers

  def initialize(filepath)
    @filepath = filepath
    @state = :init
    @row_id = 1
    @data = []
    @headers = {}
  end

  def result
    parse_spreadsheet
    { headers: headers, data: data }
  end

  private

  attr_reader :filepath, :state, :row_id

  HEADER_KEY_REGEX = /[A-Z ]+:/
  FIRST_DAY_COLUMN = 2
  LAST_DAY_COLUMN = 32

  DATE_FORMATS = ["%Y-%m-%d", "%Y-%B-%d", "%Y-%b-%d"]

  def parse_spreadsheet
    while @row_id <= spreadsheet.last_row && state != :finished
      parse_row
      jump_row
    end
  end

  def parse_row
    return @state = :header if state.eql? :init
    return parse_header if state.eql? :header
    return if state.eql?(:divider) && current_row_empty?
    return @state = :finished if current_row[0].eql? 'REMARKS:'

    parse_system
  end

  def jump_row
    @row_id += 1
  end

  def parse_header
    values = current_row.reject(&:nil?)
    (0..(values.count - 1)).each do |id|
      key = values[id]
      value = values[id + 1]
      next if HEADER_KEY_REGEX.match(key.to_s).nil?
      next unless HEADER_KEY_REGEX.match(value.to_s).nil?

      @headers[key.parameterize.underscore.to_sym] = value
    end
    @state = :divider
  end

  def parse_system
    @state = :system
    @system = current_row[0].strip.sub "\n", ' '
    jump_row

    until current_row_empty?
      parse_system_row
      jump_row
    end

    @state = :divider
    @system = nil
  end

  def parse_system_row
    row = current_row
    parameter = row[1]
    (FIRST_DAY_COLUMN..LAST_DAY_COLUMN).each do |column_id|
      value = row[column_id]
      next if value.nil?

      @data << { system: @system, parameter: parameter, value: value, taken_at: taken_at(value, column_id - FIRST_DAY_COLUMN + 1) }
    end
  end

  def current_row_empty?
    current_row.uniq.eql?([nil])
  end

  def current_row
    spreadsheet.row(row_id)
  end

  def spreadsheet
    @spreadsheet ||= Roo::Spreadsheet.open(filepath)
  end

  def taken_at(value, day)
    candidate = nil
    date = [headers.fetch(:year).to_i, headers.fetch(:month), day].join("-")
    for format in DATE_FORMATS
      begin
        candidate = Date.strptime(date, format)
      rescue Date::Error
      end
    end
    unless candidate
      raise InvalidDate
    end
    candidate
  end
end
