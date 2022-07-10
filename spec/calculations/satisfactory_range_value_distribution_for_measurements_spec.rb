require 'rails_helper'

RSpec.describe SatisfactoryRangeValueDistributionForMeasurements do
  describe '.result_for' do
    it 'counts correct statistics for given measurements' do
      vsp = create :vessel_system_parameter, min_satisfactory: 0.5, max_satisfactory: 1.5
      import = create :measurements_import
      measurements = [
        (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
        (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
        (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
        (create :measurement, value: 1.6, vessel_system_parameter: vsp, measurements_import: import),
        (create :measurement, value: 0.2, vessel_system_parameter: vsp, measurements_import: import)
      ]

      stats = SatisfactoryRangeValueDistributionForMeasurements.result_for(measurements)

      expect(stats[:in_range]).to eq(60)
      expect(stats[:underrange]).to eq(20)
      expect(stats[:overrange]).to eq(20)
    end

    context 'there is no min' do
      it 'counts correct statistics for given measurements' do
        vsp = create :vessel_system_parameter, min_satisfactory: nil, max_satisfactory: 1.5
        import = create :measurements_import
        measurements = [
          (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
          (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
          (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
          (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
          (create :measurement, value: 1.6, vessel_system_parameter: vsp, measurements_import: import),
        ]

        stats = SatisfactoryRangeValueDistributionForMeasurements.result_for(measurements)

        expect(stats.count).to eq(2)
        expect(stats[:in_range]).to eq(80)
        expect(stats[:overrange]).to eq(20)
      end
    end


    context 'there is no max' do
      it 'counts correct statistics for given measurements' do
        vsp = create :vessel_system_parameter, min_satisfactory: 0.5, max_satisfactory: nil
        import = create :measurements_import
        measurements = [
          (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
          (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
          (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
          (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
          (create :measurement, value: 0.3, vessel_system_parameter: vsp, measurements_import: import),
        ]

        stats = SatisfactoryRangeValueDistributionForMeasurements.result_for(measurements)

        expect(stats.count).to eq(2)
        expect(stats[:in_range]).to eq(80)
        expect(stats[:underrange]).to eq(20)
      end
    end

    context 'values are set in chemical program' do
      context 'are not overriden' do
        it 'takes them' do
          provider = create :chemical_provider
          system = create :vessel_system, chemical_provider: provider
          chemparam = create :chemical_provider_parameter, min_satisfactory: 0.4, max_satisfactory: 1.5, system: system.system, chemical_provider: provider
          vsp = create :vessel_system_parameter, min_satisfactory: nil, max_satisfactory: nil, parameter: chemparam.parameter, vessel_system: system
          import = create :measurements_import
          measurements = [
            (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
            (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
            (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
            (create :measurement, value: 1.7, vessel_system_parameter: vsp, measurements_import: import),
            (create :measurement, value: 0.3, vessel_system_parameter: vsp, measurements_import: import),
          ]

          stats = SatisfactoryRangeValueDistributionForMeasurements.result_for(measurements)

          expect(stats.count).to eq(3)
          expect(stats[:in_range]).to eq(60)
          expect(stats[:underrange]).to eq(20)
          expect(stats[:overrange]).to eq(20)
        end
      end

      context 'are overriden' do
        it 'ignores them' do
          program = create :chemical_provider
          system = create :vessel_system, chemical_provider: program
          chemparam = create :chemical_provider_parameter, min_satisfactory: 0.4, max_satisfactory: 1.5, system: system.system, chemical_provider: program
          vsp = create :vessel_system_parameter, min_satisfactory: 0.5, max_satisfactory: nil, parameter: chemparam.parameter, vessel_system: system
          import = create :measurements_import
          measurements = [
            (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
            (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
            (create :measurement, value: 1, vessel_system_parameter: vsp, measurements_import: import),
            (create :measurement, value: 1.8, vessel_system_parameter: vsp, measurements_import: import),
            (create :measurement, value: 0.3, vessel_system_parameter: vsp, measurements_import: import),
          ]

          stats = SatisfactoryRangeValueDistributionForMeasurements.result_for(measurements)

          expect(stats.count).to eq(2)
          expect(stats[:in_range]).to eq(80)
          expect(stats[:underrange]).to eq(20)
        end
      end
    end
  end
end
