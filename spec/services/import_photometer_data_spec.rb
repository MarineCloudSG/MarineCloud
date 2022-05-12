# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportPhotometerData do
  describe '#save!' do
    it 'adds measurements' do
      vessel = create :vessel
      parameter = create :parameter
      boiler_system = create :system, name: 'BOILER'
      boiler_vessel_system = create :vessel_system, vessel: vessel, system: boiler_system
      create :vessel_system_parameter, vessel_system: boiler_vessel_system, parameter: parameter
      create :parameter_source, source: :photometer_csv, code: 101, parameter: parameter, system: boiler_system
      file = Tempfile.new.tap do |f|
        f << 'Row no.,date,time,instrument serial no.,method no.,method name,range,number of results,Result 1,"units and chemical formula 1",Result 2,"units and chemical formula 2",Result 3,"units and chemical formula 3",Result 4,"units and chemical formula 4",code no.,"current instrument firmware version","instrument firmware version, at the time of measurement",Profi-Mode,user-cal,"result major id number","Consecutive stored test no.","citation code","result differentiation code 1","result status code 1","result differentiation code 2","result status code 2","result differentiation code 3","result status code 3","result differentiation code 4","result status code 4"
              1,1/1/2003,12:54:14 am,2018420,101,Chlorine L,0.02-4 mg/l Cl2,3,0.57,mg/l free Cl2,1.90,mg/l comb. Cl2,2.47,mg/l total Cl2,,,0,V012.013.4.003.067,V012.013.4.003.067,0,0,19,0,0,2,0,3,0,4,0,,
              1,1/1/2003,12:54:14 am,2018420,101,Chlorine L,0.02-4 mg/l Cl2,3,Underrange,mg/l free Cl2,1.90,mg/l comb. Cl2,2.47,mg/l total Cl2,,,0,V012.013.4.003.067,V012.013.4.003.067,0,0,19,0,0,2,0,3,0,4,0,,
              1,1/1/2003,12:54:14 am,2018420101,101,Chlorine L,0.02-4 mg/l Cl2,3,Overrange,mg/l free Cl2,1.90,mg/l comb. Cl2,2.47,mg/l total Cl2,,,0,V012.013.4.003.067,V012.013.4.003.067,0,0,19,0,0,2,0,3,0,4,0,,'
        f.close
      end
      uploaded_file = Rack::Test::UploadedFile.new(file.path, 'text/csv')

      expect do
        ImportPhotometerData.call(file: uploaded_file, vessel: vessel).result
      end.to change { Measurement.all.count }.by 3
      measurements = Measurement.all
      expect(measurements[0]).to have_attributes(parameter: parameter, value: 0.57, vessel: vessel)
      expect(measurements[1]).to have_attributes(parameter: parameter, value: 0, vessel: vessel)
      expect(measurements[2]).to have_attributes(parameter: parameter, value: 0, vessel: vessel)

      file.unlink
    end

    context "when measurement method doesn't exists" do
      it 'raises an error' do
        vessel = create :vessel
        file = Tempfile.new.tap do |f|
          f << 'Row no.,date,time,instrument serial no.,method no.,method name,range,number of results,Result 1,"units and chemical formula 1",Result 2,"units and chemical formula 2",Result 3,"units and chemical formula 3",Result 4,"units and chemical formula 4",code no.,"current instrument firmware version","instrument firmware version, at the time of measurement",Profi-Mode,user-cal,"result major id number","Consecutive stored test no.","citation code","result differentiation code 1","result status code 1","result differentiation code 2","result status code 2","result differentiation code 3","result status code 3","result differentiation code 4","result status code 4"
                1,1/1/2003,12:54:14 am,2018420,101,Chlorine L,0.02-4 mg/l Cl2,3,0.57,mg/l free Cl2,1.90,mg/l comb. Cl2,2.47,mg/l total Cl2,,,0,V012.013.4.003.067,V012.013.4.003.067,0,0,19,0,0,2,0,3,0,4,0,,'
          f.close
        end
        uploaded_file = Rack::Test::UploadedFile.new(file.path, 'text/csv')

        expect { ImportPhotometerData.call(file: uploaded_file, vessel: vessel) }
          .to raise_error(ActiveRecord::RecordNotFound)

        file.unlink
      end
    end

    context 'when file is not text/csv' do
      it 'raises an error' do
        vessel = create :vessel
        file = Tempfile.new
        uploaded_file = Rack::Test::UploadedFile.new(file.path, 'image/jpeg')

        expect { ImportPhotometerData.call(file: uploaded_file, vessel: vessel) }
          .to raise_error(ArgumentError)

        file.unlink
      end
    end
  end
end
