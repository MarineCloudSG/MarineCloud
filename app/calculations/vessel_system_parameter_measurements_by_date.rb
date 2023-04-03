class VesselSystemParameterMeasurementsByDate < Patterns::Calculation

  private

  def result
    Measurement.joins(:measurements_import).where(id: measurement_ids).order(:taken_at).map do |measurement|
      if measurement.measurements_import.source.to_sym == MeasurementsImport::MANUAL_XLSX_SOURCE and measurement.state.to_sym != :in_range
        if measurement.state.to_sym == :overrange
          measurement.value = vessel_system_parameter.parameter.overrange.to_f
        elsif measurement.state.to_sym == :underrange
          measurement.value = vessel_system_parameter.parameter.underrange.to_f
        else
          measurement.value = measurement.value.to_f
        end
      end
      measurement
    end
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

      measurements += base_query.where(measurements_imports: { source: selected_source }).group('DATE(measurements.taken_at)')
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
