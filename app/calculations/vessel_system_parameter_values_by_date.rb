class VesselSystemParameterValuesByDate < Patterns::Calculation

  private

  def result
    Hash[*raw_measurements.flatten]
  end

  def raw_measurements
    vessel_system_parameter.measurements
                           .where(taken_at: date_range)
                           .order(:taken_at)
                           .pluck(:taken_at, :value)
                           .map { |row| [row[0].to_date, row[1]]}
  end

  def vessel_system_parameter
    options.fetch(:vessel_system_parameter)
  end

  def date_range
    start_day..end_day
  end

  def end_day
    options.fetch(:end_day).to_date
  end

  def start_day
    options.fetch(:start_day).to_date
  end
end
