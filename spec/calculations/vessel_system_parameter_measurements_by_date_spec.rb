# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VesselSystemParameterMeasurementsByDate do
  subject { VesselSystemParameterMeasurementsByDate.result_for(
    date_range: date_range,
    vessel_system_parameter: vessel_system_parameter
  ) }
  describe '.result' do
    let(:vessel) { create :vessel }
    let(:parameter) { create :parameter }
    let(:boiler_system) { create :system, name: 'BOILER' }
    let(:boiler_vessel_system) { create :vessel_system, vessel: vessel, system: boiler_system }
    let(:vessel_system_parameter) { create :vessel_system_parameter, vessel_system: boiler_vessel_system, parameter: parameter }

    context "single month" do
      let(:date_range) { Date.new(2020, 1, 1)..Date.new(2020, 1, 31) }

      let!(:expected_measurements) do
        date_range.map do |day|
          create :measurement, taken_at: day, vessel_system_parameter: vessel_system_parameter, measurements_import: import
        end
      end

      context "photometer import" do
        let(:import) { create :measurements_import, vessel: vessel, created_at: date_range.last, source: MeasurementsImport::PHOTOMETER_CSV_SOURCE }
        it 'takes proper results' do
          expect(subject.count).to be expected_measurements.count
          subject.zip(expected_measurements).each do |result, measurement|
            expect(result.value).to eq(measurement.value)
          end
        end
      end

      context "manual input import" do
        let(:import) { create :measurements_import, vessel: vessel, created_at: date_range.last, source: MeasurementsImport::MANUAL_XLSX_SOURCE }
        it 'takes proper results' do
          expect(subject.count).to be expected_measurements.count
          subject.zip(expected_measurements).each do |result, measurement|
            expect(result.value).to eq(measurement.value)
          end
        end
      end

      context "manual input and photometer import" do
        let(:import) { create :measurements_import, vessel: vessel, created_at: date_range.last, source: MeasurementsImport::PHOTOMETER_CSV_SOURCE }
        it 'takes proper results' do
          # create manual input import which should be ignored
          manual_input_import = create :measurements_import, vessel: vessel, created_at: date_range.last, source: MeasurementsImport::MANUAL_XLSX_SOURCE
          date_range.map do |day|
            create :measurement, taken_at: day, vessel_system_parameter: vessel_system_parameter, measurements_import: manual_input_import
          end
          expect(subject.count).to be expected_measurements.count
          subject.zip(expected_measurements).each do |result, measurement|
            expect(result.value).to eq(measurement.value)
          end
        end
      end
    end

    context "there are multiple measurements for a single day" do
      let(:date_range) { Date.new(2020, 1, 1)..Date.new(2020, 1, 31) }
      let(:import1) { create :measurements_import, vessel: vessel, created_at: date_range.last, source: MeasurementsImport::PHOTOMETER_CSV_SOURCE }
      let(:import2) { create :measurements_import, vessel: vessel, created_at: date_range.last, source: MeasurementsImport::PHOTOMETER_CSV_SOURCE }

      it "selects only first one" do
        taken_at = DateTime.new(2020, 1, 7, 14, 1)
        measurement1 = create :measurement, measurements_import: import1, taken_at: taken_at, value: 1, vessel_system_parameter: vessel_system_parameter
        measurement2 = create :measurement, measurements_import: import1, taken_at: taken_at + 1.second, value: 2, vessel_system_parameter: vessel_system_parameter
        measurement3 = create :measurement, measurements_import: import2, taken_at: taken_at + 2.seconds, value: 3, vessel_system_parameter: vessel_system_parameter
        measurement4 = create :measurement, measurements_import: import2, taken_at: taken_at + 3.seconds, value: 4, vessel_system_parameter: vessel_system_parameter

        expect(subject.count).to eq(1)
        expect(subject[0].value).to eq(1)
      end
    end

    context "multiple months" do
      let(:date_range) { Date.new(2020, 1, 15)..Date.new(2020, 3, 10) }
      let(:photometer_import) { create :measurements_import, vessel: vessel, created_at: date_range.last, source: MeasurementsImport::PHOTOMETER_CSV_SOURCE }
      let(:manual_import) { create :measurements_import, vessel: vessel, created_at: date_range.last, source: MeasurementsImport::MANUAL_XLSX_SOURCE }
      let!(:expected_measurements) do
        measurements = (Date.new(2020, 1, 15)..Date.new(2020, 1, 31)).map do |day|
          create :measurement, taken_at: day, vessel_system_parameter: vessel_system_parameter, measurements_import: photometer_import
        end
        measurements += (Date.new(2020, 2, 1)..Date.new(2020, 2, 29)).map do |day|
          create :measurement, taken_at: day, vessel_system_parameter: vessel_system_parameter, measurements_import: manual_import
          create :measurement, taken_at: day, vessel_system_parameter: vessel_system_parameter, measurements_import: photometer_import
        end
        measurements += (Date.new(2020, 3, 1)..Date.new(2020, 3, 10)).map do |day|
          create :measurement, taken_at: day, vessel_system_parameter: vessel_system_parameter, measurements_import: manual_import
        end
        measurements
      end

      context "manual input and photometer import" do

        it 'takes proper results' do
          expect(subject.count).to be expected_measurements.count
          subject.zip(expected_measurements).each do |result, measurement|
            expect(result.value).to eq(measurement.value)
          end
        end
      end
    end
  end
end
