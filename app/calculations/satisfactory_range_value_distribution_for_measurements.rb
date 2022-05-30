class SatisfactoryRangeValueDistributionForMeasurements < Patterns::Calculation

  private

  def result
    applicable_value_states.map { |s| [s, state_percentage(s)] }.to_h
  end

  def state_percentage(state)
    state_values_count(state).to_f / measurements.count * 100
  end

  def state_values_count(state)
    measurements.select { |row| row.state.to_sym == state }.count
  end

  def applicable_value_states
    Measurement.states.keys.map(&:to_sym).select { |s| state_applicable?(s) }
  end

  def state_applicable?(state)
    return false if state == :underrange && lowest_satisfactory_range.nil?
    return false if state == :overrange && highest_satisfactory_range.nil?

    true
  end

  def lowest_satisfactory_range
    vessel_system_parameter&.lowest_satisfactory_range
  end

  def highest_satisfactory_range
    vessel_system_parameter&.highest_satisfactory_range
  end

  def vessel_system_parameter
    measurements.first&.vessel_system_parameter
  end

  alias measurements subject
end
