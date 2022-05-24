class VesselSystemParameterMeasurementsByDate < Patterns::Calculation

  private

  def result
    measurements_with_photometer_precedence.map do |row|
      [
        row[0].to_date,
        {
          value: row[1],
          state: row[2]
        }
      ]
    end
  end

  def measurements_with_photometer_precedence
    measurements = []
    current_start_date = date_range.first
    while current_start_date < date_range.last
      current_end_date = [date_range.last, current_start_date.end_of_month].min
      base_query = vessel_system_parameter.measurements.joins(:measurements_import).where(taken_at: current_start_date..current_end_date)
      if base_query.where(measurements_imports: { source: MeasurementsImport::PHOTOMETER_CSV_SOURCE }).exists?
        selected_source = MeasurementsImport::PHOTOMETER_CSV_SOURCE
      else
        selected_source = MeasurementsImport::MANUAL_XLSX_SOURCE
      end
      measurements += base_query.order(:taken_at).where(measurements_imports: { source: selected_source }).pluck(:taken_at, :value, :state)
      current_start_date = current_start_date.next_month.beginning_of_month
    end
    measurements
  end

  def vessel_system_parameter
    options.fetch(:vessel_system_parameter)
  end

  def date_range
    options.fetch(:date_range)
  end
end
