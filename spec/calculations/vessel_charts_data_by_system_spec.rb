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
      parameter_ids = [vsp1.parameter_id, vsp2.parameter_id, vsp3.parameter_id]

      result = VesselChartsDataBySystem.result_for(vessel: vessel_system1.vessel, date_range: date_range, parameter_ids: parameter_ids)
      first = result['First system']
      second = result['Second system']

      expect(first.map(&:vessel_system_parameter)).to contain_exactly(vsp1, vsp2)
      expect(second.map(&:vessel_system_parameter)).to contain_exactly(vsp3)
      result.values.flatten.each { |chart_data| expect(chart_data.date_range).to eq date_range }
    end

    it 'sorts by system sort_order' do
      vessel = create :vessel
      system1 = create :system, name: 'First system', sort_order: 20
      system2 = create :system, name: 'Second system', sort_order: 5
      system3 = create :system, name: 'Third system', sort_order: 10
      vessel_system1 = create :vessel_system, vessel: vessel, system: system1
      vessel_system2 = create :vessel_system, vessel: vessel, system: system2
      vessel_system3 = create :vessel_system, vessel: vessel, system: system3
      parameter1 = create :vessel_system_parameter, vessel_system: vessel_system1
      parameter2 = create :vessel_system_parameter, vessel_system: vessel_system2
      parameter3 = create :vessel_system_parameter, vessel_system: vessel_system3
      date_range = Date.new(2020, 5, 1).all_month
      parameter_ids = [parameter1.parameter.id, parameter2.parameter.id, parameter3.parameter.id]

      result = VesselChartsDataBySystem.result_for(vessel: vessel, date_range: date_range, parameter_ids: parameter_ids)

      expect(result.keys[0]).to eq('Second system')
      expect(result.keys[1]).to eq('Third system')
      expect(result.keys[2]).to eq('First system')
    end

    it 'sorts by parameter sort_order' do
      vessel = create :vessel
      vessel_system = create :vessel_system, vessel: vessel
      parameter1 = create :parameter, name: 'First parameter', sort_order: 20
      parameter2 = create :parameter, name: 'Second parameter', sort_order: 5
      parameter3 = create :parameter, name: 'Third parameter', sort_order: 10
      create :vessel_system_parameter, vessel_system: vessel_system, parameter: parameter1
      create :vessel_system_parameter, vessel_system: vessel_system, parameter: parameter2
      create :vessel_system_parameter, vessel_system: vessel_system, parameter: parameter3
      date_range = Date.new(2020, 5, 1).all_month
      parameter_ids = [parameter1.id, parameter2.id, parameter3.id]

      result = VesselChartsDataBySystem.result_for(vessel: vessel, date_range: date_range, parameter_ids: parameter_ids)

      expect(result.values[0][0].name).to eq('Second parameter')
      expect(result.values[0][1].name).to eq('Third parameter')
      expect(result.values[0][2].name).to eq('First parameter')
    end
  end
end
