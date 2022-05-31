# frozen_string_literal: true

require 'rails_helper'

def create_vessel_system_with_parameters_and_sources(vessel:, system:, codes:)
  vessel_system = create :vessel_system, vessel: vessel, system: system

  codes.each do |code|
    name = code.humanize
    parameter = Parameter.find_by(name: name)
    parameter ||= create :parameter, name: name
    create :vessel_system_parameter, vessel_system: vessel_system, parameter: parameter, code: code
  end

  vessel_system
end

RSpec.describe 'Manual measurement data uploads', type: :request do
  describe 'POST /create' do
    it 'imports xlsx data and persists information about import occurence' do
      user = create :user
      vessel = create :vessel, user: user
      file = fixture_file_upload('manual_measurements_february_feed_water.xlsx',
                                 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      system = create :system, name: 'FEEDWATER'
      create_vessel_system_with_parameters_and_sources(
        system: system,
        vessel: vessel,
        codes: %w[HARDNESS CHLORIDE PH CONDUCTIVITY APPEARANCE TEMPERATURE]
      )
      sign_in user


      expect do
        post "/vessels/#{vessel.id}/manual_measurements_data_uploads",
             params: { vessel: { manual_measurements_data_file: file } }
      end.to change { vessel.measurements.count }.by(145)
         .and change { vessel.measurements_imports.count }.by(1)
      expect(response).to have_http_status(302)
      expect(vessel.measurements.first).to have_attributes(value: 651)
      expect(vessel.measurements.last).to have_attributes(value: 496)
      expect(vessel.measurements_imports.last.tested_by).to eq('Andrew Flintoff')
    end

    context 'file is not xlsx type' do
      it 'displays an error and redirects to vessel dashboard' do
        user = create :user
        vessel = create :vessel, user: user
        file = Tempfile.new
        sign_in user

        post "/vessels/#{vessel.id}/manual_measurements_data_uploads",
             params: { vessel: { manual_measurements_data_file: Rack::Test::UploadedFile.new(file.path, 'image/jpeg') } }

        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq 'Upload failed - please upload XLSX file'

        file.unlink
      end
    end
  end
end
