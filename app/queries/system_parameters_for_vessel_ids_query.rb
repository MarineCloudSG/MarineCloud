class SystemParametersForVesselIdsQuery < Patterns::Query
  queries VesselSystemParameter

  private

  def query
    VesselSystemParameter.joins(:vessel_system)
                         .includes(:parameter, :system)
                         .where('vessel_systems.vessel_id': vessel_ids)
                         .order('vessel_systems.system_id')
  end

  def vessel_ids
    options.fetch(:vessel_ids)
  end
end
