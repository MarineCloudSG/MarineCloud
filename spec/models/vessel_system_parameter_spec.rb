# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VesselSystemParameter, type: :model do
  describe '#lowest_satisfactory_range' do
    context 'when there is min_satisfactory or max_satisfactory defined' do
      it 'returns lower range from vessel system parameter' do
        param = create :parameter, min_satisfactory: 10, max_satisfactory: 20

        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: 25,
                                                 max_satisfactory: nil).lowest_satisfactory_range).to eq 25
        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: nil,
                                                 max_satisfactory: 50).lowest_satisfactory_range).to eq nil
        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: 11,
                                                 max_satisfactory: 51).lowest_satisfactory_range).to eq 11
      end
    end

    context 'when there is no min_satisfactory or max_satisfactory' do
      it 'returns range from parameter' do
        param = create :parameter, min_satisfactory: 10, max_satisfactory: 20

        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: nil,
                                                 max_satisfactory: nil).lowest_satisfactory_range).to eq 10
      end
    end
  end

  describe '#highest_satisfactory_range' do
    context 'when there is min_satisfactory or max_satisfactory defined' do
      it 'returns upper range from vessel system parameter' do
        param = create :parameter, min_satisfactory: 10, max_satisfactory: 20

        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: 25,
                                                 max_satisfactory: nil).highest_satisfactory_range).to eq nil
        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: nil,
                                                 max_satisfactory: 50).highest_satisfactory_range).to eq 50
        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: 11,
                                                 max_satisfactory: 51).highest_satisfactory_range).to eq 51
      end
    end

    context 'when there is no min_satisfactory or max_satisfactory' do
      it 'returns range from parameter' do
        param = create :parameter, min_satisfactory: 10, max_satisfactory: 20

        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: nil,
                                                 max_satisfactory: nil).highest_satisfactory_range).to eq 20
      end
    end
  end

  describe '#overrides_satisfactory?' do
    context 'there is either min_satisfactory, max_satisfactory or both' do
      it 'returns true' do
        expect((create :vessel_system_parameter, min_satisfactory: 1.2, max_satisfactory: nil).overrides_satisfactory?)
          .to eq true
        expect((create :vessel_system_parameter, min_satisfactory: nil, max_satisfactory: 5.5).overrides_satisfactory?)
          .to eq true
        expect((create :vessel_system_parameter, min_satisfactory: 1.2, max_satisfactory: 2.5).overrides_satisfactory?)
          .to eq true
      end
    end

    context 'there is no min_satisfactory or max_satisfactory defined' do
      it 'returns false' do
        expect((create :vessel_system_parameter, min_satisfactory: nil, max_satisfactory: nil).overrides_satisfactory?)
          .to eq false
      end
    end
  end
end
