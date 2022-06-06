class PhotometerDataParser
  def self.read(*args)
    new(*args).result
  end

  def initialize(filepath)
    @filepath = filepath
  end

  def result
    @result ||= csv_rows.map { |row| row_to_hash(row) }
  end

  private

  attr_reader :filepath

  def csv_rows
    @csv_rows ||= CSV.open(filepath, headers: true, liberal_parsing: true, col_sep: ';')
  end

  def row_to_hash(row)
    {
      instrument_serial: row['instrument serial no.'],
      method_name: row['method name'],
      method_number: row['method no.'].to_i,
      range: row_range(row),
      value: row['Result 1'],
      code: row['code no.'].to_i,
      taken_at: Time.parse(row['time'], Date.parse(row['date'])).to_datetime
    }
  end

  def row_range(row)
    match = range_match(row)
    {
      from: match[1].to_f,
      to: match[2].to_f
    }
  end

  def range_match(row)
    /([\d.]+)-([\d.]+)\s/.match(row['range'])
  end
end
