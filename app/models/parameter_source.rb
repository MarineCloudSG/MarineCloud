class ParameterSource < ApplicationRecord
  MANUAL_XLSX_SOURCE = :manual_xlsx
  PHOTOMETER_CSV_SOURCE = :photometer_csv
  SOURCES_AVAILABLE = [MANUAL_XLSX_SOURCE, PHOTOMETER_CSV_SOURCE].freeze

  enum source: SOURCES_AVAILABLE
  belongs_to :parameter
  belongs_to :system, optional: true
end
