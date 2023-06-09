# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportPhotometerData do
  describe '#save!' do
    xit 'adds measurements' do
      vessel = create :vessel
      parameter = create :parameter
      boiler_system = create :system, name: 'BOILER'
      boiler_vessel_system = create :vessel_system, vessel: vessel, system: boiler_system, code: 11
      create :vessel_system_parameter, vessel_system: boiler_vessel_system, parameter: parameter, code: 101
      file = Tempfile.new.tap do |f|
        f << 'Row no.;date;time;instrument serial no.;method no.;method name;range;number of results;Result 1;"units and chemical formula 1";Result 2;"units and chemical formula 2";Result 3;"units and chemical formula 3";Result 4;"units and chemical formula 4";code no.;"current instrument firmware version";"instrument firmware version; at the time of measurement";Profi-Mode;user-cal;"result major id number";"Consecutive stored test no.";"citation code";"result differentiation code 1";"result status code 1";"result differentiation code 2";"result status code 2";"result differentiation code 3";"result status code 3";"result differentiation code 4";"result status code 4"
              1;1/1/2003;12:54:14 am;2018420;101;Chlorine L;0.02-4 mg/l Cl2;3;0.57;mg/l free Cl2;1.90;mg/l comb. Cl2;2.47;mg/l total Cl2;;;11;V012.013.4.003.067;V012.013.4.003.067;0;0;19;0;0;2;0;3;0;4;0;;
              1;1/1/2003;12:54:14 am;2018420;101;Chlorine L;0.02-4 mg/l Cl2;3;1;mg/l free Cl2;1.90;mg/l comb. Cl2;2.47;mg/l total Cl2;;;11;V012.013.4.003.067;V012.013.4.003.067;0;0;19;0;0;2;0;3;0;4;0;;
              1;1/1/2003;12:54:14 am;2018420101;101;Chlorine L;0.02-4 mg/l Cl2;3;2.25;mg/l free Cl2;1.90;mg/l comb. Cl2;2.47;mg/l total Cl2;;;11;V012.013.4.003.067;V012.013.4.003.067;0;0;19;0;0;2;0;3;0;4;0;;'
        f.close
      end
      uploaded_file = OpenStruct.new(path: file, content_type: 'text/csv')

      expect do
        ImportPhotometerData.call(file: uploaded_file, vessel: vessel).result
      end.to change { Measurement.all.count }.by 3
      measurements = Measurement.all
      expect(measurements[0]).to have_attributes(parameter: parameter, value: 0.57, vessel: vessel, state: :in_range.to_s)
      expect(measurements[1]).to have_attributes(parameter: parameter, value: 1.0, vessel: vessel, state: :in_range.to_s)
      expect(measurements[2]).to have_attributes(parameter: parameter, value: 2.25, vessel: vessel, state: :in_range.to_s)

      file.unlink
    end

    context "when measurement method doesn't exists" do
      xit 'raises an error' do
        vessel = create :vessel
        file = Tempfile.new.tap do |f|
          f << 'Row no.;date;time;instrument serial no.;method no.;method name;range;number of results;Result 1;"units and chemical formula 1";Result 2;"units and chemical formula 2";Result 3;"units and chemical formula 3";Result 4;"units and chemical formula 4";code no.;"current instrument firmware version";"instrument firmware version; at the time of measurement";Profi-Mode;user-cal;"result major id number";"Consecutive stored test no.";"citation code";"result differentiation code 1";"result status code 1";"result differentiation code 2";"result status code 2";"result differentiation code 3";"result status code 3";"result differentiation code 4";"result status code 4"
                1;1/1/2003;12:54:14 am;2018420;101;Chlorine L;0.02-4 mg/l Cl2;3;0.57;mg/l free Cl2;1.90;mg/l comb. Cl2;2.47;mg/l total Cl2;;;0;V012.013.4.003.067;V012.013.4.003.067;0;0;19;0;0;2;0;3;0;4;0;;'
          f.close
        end
        uploaded_file = OpenStruct.new(path: file, content_type: 'text/csv')

        expect { ImportPhotometerData.call(file: uploaded_file, vessel: vessel) }
          .to raise_error(ParsedVesselPhotometerDataRow::HandledImportException)

        file.unlink
      end
    end

    context 'when value is out of range' do
      xit 'adds measurement with border range value and sets in_range flag to false' do
        vessel = create :vessel
        parameter = create :parameter
        boiler_system = create :system, name: 'BOILER'
        boiler_vessel_system = create :vessel_system, vessel: vessel, system: boiler_system, code: 11
        create :vessel_system_parameter, vessel_system: boiler_vessel_system, parameter: parameter, code: 101
        file = Tempfile.new.tap do |f|
          f << 'Row no.;date;time;instrument serial no.;method no.;method name;range;number of results;Result 1;"units and chemical formula 1";Result 2;"units and chemical formula 2";Result 3;"units and chemical formula 3";Result 4;"units and chemical formula 4";code no.;"current instrument firmware version";"instrument firmware version; at the time of measurement";Profi-Mode;user-cal;"result major id number";"Consecutive stored test no.";"citation code";"result differentiation code 1";"result status code 1";"result differentiation code 2";"result status code 2";"result differentiation code 3";"result status code 3";"result differentiation code 4";"result status code 4"
              1;1/1/2003;12:54:14 am;2018420;101;Chlorine L;0.02-4 mg/l Cl2;3;Underrange;mg/l free Cl2;1.90;mg/l comb. Cl2;2.47;mg/l total Cl2;;;11;V012.013.4.003.067;V012.013.4.003.067;0;0;19;0;0;2;0;3;0;4;0;;
              1;1/1/2003;12:54:14 am;2018420101;101;Chlorine L;0.02-4 mg/l Cl2;3;Overrange;mg/l free Cl2;1.90;mg/l comb. Cl2;2.47;mg/l total Cl2;;;11;V012.013.4.003.067;V012.013.4.003.067;0;0;19;0;0;2;0;3;0;4;0;;'
          f.close
        end
        uploaded_file = OpenStruct.new(path: file, content_type: 'text/csv')

        expect do
          ImportPhotometerData.call(file: uploaded_file, vessel: vessel).result
        end.to change { Measurement.all.count }.by 2
        measurements = Measurement.all
        expect(measurements[0]).to have_attributes(parameter: parameter, value: 0.02, vessel: vessel, state: :underrange.to_s)
        expect(measurements[1]).to have_attributes(parameter: parameter, value: 4, vessel: vessel, state: :overrange.to_s)

        file.unlink
      end
    end

    context 'when file is not csv nor xlsx' do
      xit 'raises an error' do
        user = create :user
        vessel = create :vessel, user: user
        file = Tempfile.new
        uploaded_file = OpenStruct.new(path: file, content_type: 'image/jpeg')

        expect do
          ImportPhotometerData.call(file: uploaded_file, vessel: vessel).result
        end.to raise_error(ImportPhotometerData::UnsupportedFileTypeError)
      end
    end

    context 'parameter has multiplier different than 1' do
      xit 'multiplies value of measurement before saving' do
        vessel = create :vessel
        parameter = create :parameter, photometer_value_multiplier: 1.5
        boiler_system = create :system, name: 'BOILER'
        boiler_vessel_system = create :vessel_system, vessel: vessel, system: boiler_system, code: 11
        create :vessel_system_parameter, vessel_system: boiler_vessel_system, parameter: parameter, code: 101
        file = Tempfile.new.tap do |f|
          f << 'Row no.;date;time;instrument serial no.;method no.;method name;range;number of results;Result 1;"units and chemical formula 1";Result 2;"units and chemical formula 2";Result 3;"units and chemical formula 3";Result 4;"units and chemical formula 4";code no.;"current instrument firmware version";"instrument firmware version; at the time of measurement";Profi-Mode;user-cal;"result major id number";"Consecutive stored test no.";"citation code";"result differentiation code 1";"result status code 1";"result differentiation code 2";"result status code 2";"result differentiation code 3";"result status code 3";"result differentiation code 4";"result status code 4"
              1;1/1/2003;12:54:14 am;2018420;101;Chlorine L;0.02-4 mg/l Cl2;3;0.57;mg/l free Cl2;1.90;mg/l comb. Cl2;2.47;mg/l total Cl2;;;11;V012.013.4.003.067;V012.013.4.003.067;0;0;19;0;0;2;0;3;0;4;0;;
              1;1/1/2003;12:54:14 am;2018420;101;Chlorine L;0.02-4 mg/l Cl2;3;1;mg/l free Cl2;1.90;mg/l comb. Cl2;2.47;mg/l total Cl2;;;11;V012.013.4.003.067;V012.013.4.003.067;0;0;19;0;0;2;0;3;0;4;0;;
              1;1/1/2003;12:54:14 am;2018420101;101;Chlorine L;0.02-4 mg/l Cl2;3;2.25;mg/l free Cl2;1.90;mg/l comb. Cl2;2.47;mg/l total Cl2;;;11;V012.013.4.003.067;V012.013.4.003.067;0;0;19;0;0;2;0;3;0;4;0;;'
          f.close
        end
        uploaded_file = OpenStruct.new(path: file, content_type: 'text/csv')

        expect do
          ImportPhotometerData.call(file: uploaded_file, vessel: vessel).result
        end.to change { Measurement.all.count }.by 3
        measurements = Measurement.all
        expect(measurements[0]).to have_attributes(parameter: parameter, value: 0.855, vessel: vessel, state: :in_range.to_s)
        expect(measurements[1]).to have_attributes(parameter: parameter, value: 1.5, vessel: vessel, state: :in_range.to_s)
        expect(measurements[2]).to have_attributes(parameter: parameter, value: 3.375, vessel: vessel, state: :in_range.to_s)

        file.unlink
      end
    end
  end
end
