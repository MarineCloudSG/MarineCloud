require 'rails_helper'

RSpec.describe ConvertXlsxToCsv do
  describe '.call' do
    it 'returns converted file' do
      xlsx_file = File.path(file_fixture('photometer_data.xlsx'))
      csv_data = 'Row no.,date,time,instrument serial no.,method no.,method name,range,number of results,Result 1,"units and chemical formula 1",Result 2,"units and chemical formula 2",Result 3,"units and chemical formula 3",Result 4,"units and chemical formula 4",code no.,"current instrument firmware version","instrument firmware version, at the time of measurement",Profi-Mode,user-cal,"result major id number","Consecutive stored test no.","citation code","result differentiation code 1","result status code 1","result differentiation code 2","result status code 2","result differentiation code 3","result status code 3","result differentiation code 4","result status code 4"
1,1/1/2003,12:54:14 am,2018420,101,Chlorine L,0.02-4 mg/l Cl2,3,0.57,mg/l free Cl2,1.9,mg/l comb. Cl2,2.47,mg/l total Cl2,,,11,V012.013.4.003.067,V012.013.4.003.067,0,0,19,0,0,2,0,3,0,4,0,,
2,1/1/2003,12:54:14 am,2018420,101,Chlorine L,0.02-4 mg/l Cl2,3,1,mg/l free Cl2,1.9,mg/l comb. Cl2,2.47,mg/l total Cl2,,,11,V012.013.4.003.067,V012.013.4.003.067,0,0,19,0,0,2,0,3,0,4,0,,
3,1/1/2003,12:54:14 am,2018420101,101,Chlorine L,0.02-4 mg/l Cl2,3,2.25,mg/l free Cl2,1.9,mg/l comb. Cl2,2.47,mg/l total Cl2,,,11,V012.013.4.003.067,V012.013.4.003.067,0,0,19,0,0,2,0,3,0,4,0,,'
      csv = CSV.new(csv_data)
      result = ConvertXlsxToCsv.call(xlsx_file).result

      result_csv = CSV.open(result, col_sep: ';')

      csv.each do |row|
        result_row = result_csv.shift
        expect(result_row).to eq(row)
      end
    end
  end
end
