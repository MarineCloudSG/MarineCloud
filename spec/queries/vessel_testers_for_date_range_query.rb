# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VesselTestersForDateRangeQuery do
  describe '.call' do
    it 'selects all testers for given date range and vessel' do
      date_start = Date.new(2020, 0o1, 0o1)
      date_end = Date.new(2020, 0o2, 0o5)
      vessel = create :vessel
      create :measurements_import, created_at: date_start + 1.day, source: MeasurementsImport::MANUAL_XLSX_SOURCE,
                                   tested_by: 'Franek', vessel: vessel
      create :measurements_import, created_at: date_start + 1.week, source: MeasurementsImport::MANUAL_XLSX_SOURCE,
                                   tested_by: 'Franek', vessel: vessel
      create :measurements_import, created_at: date_start + 1.month, source: MeasurementsImport::MANUAL_XLSX_SOURCE,
                                   tested_by: 'Grzesiek', vessel: vessel

      result = VesselTestersForDateRangeQuery.call(vessel_id: vessel.id, date_range: date_start..date_end)

      expect(result.pluck(:tested_by)).to eq(%w[Franek Grzesiek])
    end
  end
end
