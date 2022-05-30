require 'rails_helper'

RSpec.describe SatisfactoryRangeValueDistributionForMeasurements do
  describe '.result_for' do
    it 'counts correct statistics for given measurements' do
      vsp = create :vessel_system_parameter, min_satisfactory: 0.5, max_satisfactory: 1.5
      import = create :measurements_import
      measurements = [
        (create :measurement, state: :in_range, value: 1, vessel_system_parameter: vsp, measurements_import: import),
        (create :measurement, state: :in_range, value: 1, vessel_system_parameter: vsp, measurements_import: import),
        (create :measurement, state: :in_range, value: 1, vessel_system_parameter: vsp, measurements_import: import),
        (create :measurement, state: :overrange, value: 1.6, vessel_system_parameter: vsp, measurements_import: import),
        (create :measurement, state: :underrange, value: 0.2, vessel_system_parameter: vsp, measurements_import: import)
      ]

      stats = SatisfactoryRangeValueDistributionForMeasurements.result_for(measurements)

      expect(stats[:in_range]).to eq(60)
      expect(stats[:underrange]).to eq(20)
      expect(stats[:overrange]).to eq(20)
    end
  end
end
