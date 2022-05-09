# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VesselSystemParameter, type: :model do
  describe '#satisfactory_range' do
    context 'when there is min_satisfactory or max_satisfactory defined' do
      it 'returns range from vessel system parameter' do
        param = create :parameter, min_satisfactory: 10, max_satisfactory: 20

        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: 25,
                                                 max_satisfactory: nil).satisfactory_range).to eq [25, nil]
        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: nil,
                                                 max_satisfactory: 50).satisfactory_range).to eq [nil, 50]
        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: 11,
                                                 max_satisfactory: 51).satisfactory_range).to eq [11, 51]
      end
    end

    context 'when there is no min_satisfactory or max_satisfactory' do
      it 'returns range from parameter' do
        param = create :parameter, min_satisfactory: 10, max_satisfactory: 20

        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: nil,
                                                 max_satisfactory: nil).satisfactory_range).to eq [10, 20]
      end
    end
  end
end
