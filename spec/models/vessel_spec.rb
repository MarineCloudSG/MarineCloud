require 'rails_helper'

RSpec.describe Vessel, type: :model do
  describe '#last_data_upload' do
    it 'returns last measurements upload date' do
      vessel = create :vessel
      create :measurements_import, vessel: vessel, created_at: DateTime.new(2020, 1, 1)
      create :measurements_import, vessel: vessel, created_at: DateTime.new(2019, 1, 1)

      expect(vessel.last_data_upload.to_datetime).to eq(DateTime.new(2020, 1, 1))
    end
  end

  describe '#last_tested_by' do
    it 'returns tested_by from last measurement import' do
      vessel = create :vessel
      create :measurements_import, vessel: vessel, created_at: DateTime.new(2020, 1, 1), tested_by: 'Andrew', source: MeasurementsImport::MANUAL_XLSX_SOURCE
      create :measurements_import, vessel: vessel, created_at: DateTime.new(2019, 1, 1), tested_by: 'Matthew', source: MeasurementsImport::MANUAL_XLSX_SOURCE

      expect(vessel.last_tested_by).to eq('Andrew')
    end
  end
end
