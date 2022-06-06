# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PhotometerDataUploads', type: :request do
  describe 'POST /create' do
    it 'imports photometer data' do
      user = create :user
      vessel = create :vessel, user: user
      file = fixture_file_upload('photometer_data.csv', 'text/csv')
      allow(ImportPhotometerData).to receive(:call)
      sign_in user

      post "/vessels/#{vessel.id}/photometer_data_uploads",
           params: { vessel: { photometer_data_file: file } }

      expect(response).to have_http_status(302)
      expect(ImportPhotometerData).to have_received(:call)
    end

    context 'file is xlsx' do
      it 'converts the file then imports photometer data' do
        user = create :user
        vessel = create :vessel, user: user
        file = fixture_file_upload('photometer_data.xlsx',
                                   'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        allow(ConvertXlsxToCsv).to receive(:call).and_return(OpenStruct.new(result: file))
        allow(ImportPhotometerData).to receive(:call)
        sign_in user

        post "/vessels/#{vessel.id}/photometer_data_uploads",
             params: { vessel: { photometer_data_file: file } }

        expect(response).to have_http_status(302)
        expect(ConvertXlsxToCsv).to have_received(:call)
        expect(ImportPhotometerData).to have_received(:call)
      end
    end

    context 'file is not text/csv or xlsx' do
      it 'raises an error' do
        user = create :user
        vessel = create :vessel, user: user
        file = Tempfile.new
        sign_in user

        post "/vessels/#{vessel.id}/photometer_data_uploads",
             params: { vessel: { photometer_data_file: Rack::Test::UploadedFile.new(file, 'image/jpeg') } }

        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq 'Upload failed - please upload CSV or XLSX file'
      end
    end
  end
end
