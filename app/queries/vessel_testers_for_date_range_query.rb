class VesselTestersForDateRangeQuery < Patterns::Query
  queries MeasurementsImport

  private

  def query
    MeasurementsImport.where(source: MeasurementsImport::MANUAL_XLSX_SOURCE,
                             vessel_id: vessel_id,
                             taken_at: date_range)
                      .select(:tested_by)
                      .distinct
  end

  def vessel_id
    options.fetch(:vessel_id)
  end

  def date_range
    options.fetch(:date_range)
  end
end
