require 'rails_helper'

RSpec.describe VesselChartsDataBySystem do
  describe '.result_for' do
    it 'returns charts for all parameters grouped by systems' do
      vessel = create :vessel
      system1 = create :system, name: 'First system'
      system2 = create :system, name: 'Second system'
      vessel_system1 = create :vessel_system, vessel: vessel, system: system1
      vessel_system2 = create :vessel_system, vessel: vessel, system: system2
      vsp1 = create :vessel_system_parameter, vessel_system: vessel_system1
      vsp2 = create :vessel_system_parameter, vessel_system: vessel_system1
      vsp3 = create :vessel_system_parameter, vessel_system: vessel_system2
      date_range = Date.new(2020, 5, 1).all_month

      result = VesselChartsDataBySystem.result_for(vessel: vessel_system1.vessel, date_range: date_range)
      first = result['First system']
      second = result['Second system']

      expect(first.map(&:vessel_system_parameter)).to contain_exactly(vsp1, vsp2)
      expect(second.map(&:vessel_system_parameter)).to contain_exactly(vsp3)
      result.values.flatten.each { |chart_data| expect(chart_data.date_range).to eq date_range }
    end
  end
end
