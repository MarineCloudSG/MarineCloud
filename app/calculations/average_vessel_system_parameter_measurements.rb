class AverageVesselSystemParameterMeasurements < Patterns::Calculation

  private

  def result
    raw_measurements.map do |row|
      [
        row[0],
        row[1]
      ]
    end
  end

  def raw_measurements
    Measurement
      .joins(:vessel, :parameter, :system)
      .where(taken_at: date_range,
             parameter: { id: parameter.id },
             system: { id: system.id },
             vessels: { id: vessel_ids })
      .group('vessels.name')
      .average(:value)
  end

  def system
    options.fetch(:system)
  end

  def parameter
    options.fetch(:parameter)
  end

  def vessel_ids
    Vessel.joins(:vessel_group).where(vessel_group_id: vessel_group_ids).pluck(:id).uniq
  end

  def vessel_group_ids
    options.fetch(:vessel_group_ids)
  end

  def date_range
    options.fetch(:date_range)
  end
end
