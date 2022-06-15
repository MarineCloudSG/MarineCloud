class VesselSystemParameterMeasurementsByDate < Patterns::Calculation

  private

  def result
    Measurement.where(id: measurement_ids).order(:taken_at)
  end

  def measurement_ids
    measurements = []
    current_start_date = date_range.first
    while current_start_date < date_range.last
      current_end_date = [date_range.last, current_start_date.end_of_month].min
      base_query = vessel_system_parameter.measurements
                                          .select('MIN(measurements.id) AS id')
                                          .joins(:measurements_import)
                                          .where(taken_at: current_start_date..current_end_date)

      if base_query.where(measurements_imports: { source: MeasurementsImport::PHOTOMETER_CSV_SOURCE }).exists?
        selected_source = MeasurementsImport::PHOTOMETER_CSV_SOURCE
      else
        selected_source = MeasurementsImport::MANUAL_XLSX_SOURCE
      end

      measurements += base_query.where(measurements_imports: { source: selected_source }).group('DATE(taken_at)')
      current_start_date = current_start_date.next_month.beginning_of_month
    end
    measurements.pluck(:id)
  end

  def vessel_system_parameter
    options.fetch(:vessel_system_parameter)
  end

  def date_range
    options.fetch(:date_range)
  end
end
