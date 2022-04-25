# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PhotometerDataUploads', type: :request do
  describe 'POST /create' do
    it 'imports photometer data' do
      vessel = create :vessel
      file = fixture_file_upload('photometer_data.csv', 'text/csv')
      allow(ImportPhotometerData).to receive(:call)

      create_user_and_sign_in
      post "/vessels/#{vessel.id}/photometer_data_uploads", params: { vessel: { photometer_data_file: file } }

      expect(response).to have_http_status(:success)
      expect(ImportPhotometerData).to have_received(:call)
    end
  end
end
