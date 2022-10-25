class SatisfactoryRangeValueDistributionForMeasurements < Patterns::Calculation

  private

  def result
    applicable_states.map { |state| [state, states_percentages[state]] }.to_h
  end

  def applicable_states
    states = [:in_range]
    states << :overrange unless highest_satisfactory_range.nil?
    states << :underrange unless lowest_satisfactory_range.nil?
    states
  end

  def states_percentages
    @states_percentages ||= states_values_counts.transform_values { |count| count.to_f / measurements.count * 100 }
  end

  def states_values_counts
    measurements_with_value_states.group_by(&:state).transform_values(&:count)
  end

  def measurements_with_value_states
    measurements.map { |m| OpenStruct.new(state: measurement_value_state(m), measurement: m) }
  end

  def measurement_value_state(measurement)
    return :underrange if !lowest_satisfactory_range.nil? && measurement.value < lowest_satisfactory_range
    return :overrange if !highest_satisfactory_range.nil? && measurement.value > highest_satisfactory_range

    :in_range
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
