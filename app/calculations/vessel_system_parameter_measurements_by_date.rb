class VesselSystemParameterMeasurementsByDate < Patterns::Calculation

  private

  def result
    raw_measurements.map do |row|
      [
        row[0].to_date,
        {
          value: row[1],
          state: row[2]
        }
      ]
    end
  end

  def raw_measurements
    vessel_system_parameter.measurements
                           .where(taken_at: date_range)
                           .order(:taken_at)
                           .pluck(:taken_at, :value, :state)
  end

  def vessel_system_parameter
    options.fetch(:vessel_system_parameter)
  end

  def date_range
    options.fetch(:date_range)
  end
end
