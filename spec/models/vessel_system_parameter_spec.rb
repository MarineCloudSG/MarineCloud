# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VesselSystemParameter, type: :model do
  describe '#lowest_satisfactory_range' do
    context 'when there is min_satisfactory or max_satisfactory defined' do
      it 'returns lower range from vessel system parameter' do
        param = create :parameter

        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: 25,
                                                 max_satisfactory: nil).lowest_satisfactory_range).to eq 25
        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: nil,
                                                 max_satisfactory: 50).lowest_satisfactory_range).to eq nil
        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: 11,
                                                 max_satisfactory: 51).lowest_satisfactory_range).to eq 11
      end
    end

    context 'when there is no min_satisfactory or max_satisfactory' do
      it 'returns range from chemical program parameter' do
        system = create :system
        param = create :parameter
        chemical_program_param = create :chemical_program_parameter,
                                        system: system, parameter: param,
                                        min_satisfactory: 10, max_satisfactory: 20
        vessel = create :vessel, chemical_program: chemical_program_param.chemical_program
        vessel_system = create :vessel_system, vessel: vessel, system: system
        vessel_system_param = create :vessel_system_parameter, vessel_system: vessel_system, parameter: param,
                                                               min_satisfactory: nil, max_satisfactory: nil
        expect(vessel_system_param.lowest_satisfactory_range).to eq 10
      end
    end
  end

  describe '#highest_satisfactory_range' do
    context 'when there is min_satisfactory or max_satisfactory defined' do
      it 'returns upper range from vessel system parameter' do
        param = create :parameter

        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: 25,
                                                 max_satisfactory: nil).highest_satisfactory_range).to eq nil
        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: nil,
                                                 max_satisfactory: 50).highest_satisfactory_range).to eq 50
        expect((create :vessel_system_parameter, parameter: param, min_satisfactory: 11,
                                                 max_satisfactory: 51).highest_satisfactory_range).to eq 51
      end
    end

    context 'when there is no min_satisfactory or max_satisfactory' do
      it 'returns range from chemical program parameter' do
        system = create :system
        param = create :parameter
        chemical_program_param = create :chemical_program_parameter, system: system, parameter: param,
                                                                     min_satisfactory: 10, max_satisfactory: 20
        vessel = create :vessel, chemical_program: chemical_program_param.chemical_program
        vessel_system = create :vessel_system, vessel: vessel, system: system
        vessel_system_param = create :vessel_system_parameter, vessel_system: vessel_system, parameter: param,
                                                               min_satisfactory: nil, max_satisfactory: nil
        expect(vessel_system_param.highest_satisfactory_range).to eq 20
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

  describe '#chemical_program_parameter' do
    it 'selects correct parameter for given model' do
      chemical_program = create :chemical_program
      parameter = create :parameter
      system = create :system
      chemical_program_parameter = create :chemical_program_parameter, chemical_program: chemical_program,
                                                                       parameter: parameter, system: system
      vessel = create :vessel, chemical_program: chemical_program
      vessel_system = create :vessel_system, system: system, vessel: vessel
      vessel_system_parameter = create :vessel_system_parameter, vessel_system: vessel_system, parameter: parameter

      expect(vessel_system_parameter.chemical_program_parameter).to eq(chemical_program_parameter)
    end
  end
end
