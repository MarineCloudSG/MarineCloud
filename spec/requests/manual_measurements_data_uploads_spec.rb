# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manual measurement data uploads', type: :request do
  describe 'POST /create' do
    it 'imports xlsx data and persists information about import occurence' do
      vessel = create :vessel
      file = fixture_file_upload('manual_measurements_february_feed_water.xlsx',
                                 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      date_range = Date.new(2021, 2, 1)..Date.new(2021, 2, 28)
      chloride_source = create :manual_xls_parameter_source, code: 'CHLORIDE',
                                                             parameter: (create :parameter, name: 'Chloride')
      hardness_source = create :manual_xls_parameter_source, code: 'HARDNESS',
                                                             parameter: (create :parameter, name: 'Hardness')
      temperature_source = create :manual_xls_parameter_source, code: 'TEMPERATURE',
                                                                parameter: (create :parameter, name: 'Temperature')
      create :manual_xls_parameter_source, code: 'PH', parameter: (create :parameter, name: 'pH')
      create :manual_xls_parameter_source, code: 'CONDUCTIVITY', parameter: (create :parameter, name: 'Conductivity')
      create :manual_xls_parameter_source, code: 'APPEARANCE', parameter: (create :parameter, name: 'Appearance')
      create_user_and_sign_in

      expect do
        post "/vessels/#{vessel.id}/manual_measurements_data_uploads",
             params: { vessel: { manual_measurements_data_file: file } }
      end.to change { Measurement.where(taken_at: date_range).count }.by(145)
        .and change { Measurement.where(taken_at: date_range, parameter: chloride_source.parameter).count }.by(5)
        .and change { vessel.measurements_imports.count }.by(1)
      expect(response).to have_http_status(:success)
      expect(Measurement.where(taken_at: date_range).first)
        .to have_attributes(value: '651', parameter: hardness_source.parameter)
      expect(Measurement.where(taken_at: date_range).last)
        .to have_attributes(value: '496', parameter: temperature_source.parameter)
    end
  end
end
