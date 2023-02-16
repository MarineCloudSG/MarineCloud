# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManualMeasurementsDataParser do
  describe '.read' do
    it 'reads measurements from xml file' do
      filepath = file_fixture('manual_measurements.xlsx')

      result = ManualMeasurementsDataParser.read(filepath.to_s)

      expect(result[:headers]).to include vessel_name: 'Howzat', company: 'Country Cricket', month: '1', year: '2021',
                                          tested_by: 'Andrew Flintoff'
      expect(result[:data].count).to eq 1028
      expect(result[:data].count { |row| row[:system] == 'HT CW' }).to eq 253
      expect(result[:data].count { |row| row[:parameter] == 'CHLORIDE' && row[:system] == 'HT CW' }).to eq 5
      expect(result[:data].count { |row| row[:parameter] == 'PH' && row[:system] == 'HT CW' }).to eq 31
      expect(result[:data].first).to include taken_at: Date.new(2021, 1, 1), system: 'BOILER',
                                             parameter: 'P-ALKALINITY', value: 170
      expect(result[:data].last).to include taken_at: Date.new(2021, 1, 31), system: 'LT CW',
                                            parameter: 'APPEARANCE', value: 'CLEAR'
    end
  end
end
