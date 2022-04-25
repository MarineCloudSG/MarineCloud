# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhotometerDataParser do
  describe '.read' do
    it 'reads photometer data from file' do
      filepath = file_fixture('photometer_data.csv')

      result = PhotometerDataParser.read(filepath)

      expect(result.count).to eq(4)
      expect(result[0]).to include(
        instrument_serial: '2018420',
        method_name: 'Chlorine L',
        method_number: 101,
        range: { from: 0.02, to: 4 },
        value: '0.57',
        code: 0,
        taken_at: DateTime.new(2003, 1, 1, 0, 54, 14, '+1')
      )
      expect(result[1]).to include(
        instrument_serial: '2018420',
        method_name: 'Calcium hardn. T',
        method_number: 190,
        range: { from: 50, to: 900 },
        value: 'Underrange',
        code: 0,
        taken_at: DateTime.new(2003, 1, 1, 0, 55, 34, '+1')
      )
      expect(result[2]).to include(
        instrument_serial: '2018420',
        method_name: 'pH-value T',
        method_number: 330,
        range: { from: 6.5, to: 8.4 },
        value: '7.46',
        code: 0,
        taken_at: DateTime.new(2003, 1, 1, 0, 56, 28, '+1')
      )
      expect(result[3]).to include(
        instrument_serial: '2018420',
        method_name: 'tot. Hardness T',
        method_number: 200,
        range: { from: 2.0, to: 50 },
        value: '47.00',
        code: 0,
        taken_at: DateTime.new(2003, 1, 1, 0, 58, 25, '+1')
      )
    end
  end
end
