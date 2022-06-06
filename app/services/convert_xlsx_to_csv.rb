class ConvertXlsxToCsv < Patterns::Service
  def initialize(filepath)
    @filepath = filepath
  end

  def call
    write_tempfile
    tempfile
  end

  private

  attr_reader :filepath

  def write_tempfile
    tempfile.write(csv_data)
    tempfile.rewind
  end

  def tempfile
    @tempfile ||= Tempfile.new('photometer.data')
  end

  def csv_data
    Roo::Spreadsheet.open(filepath).to_csv
  end
end
