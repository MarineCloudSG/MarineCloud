# frozen_string_literal: true

class VesselsController < BaseController
  def index
    return redirect_to action: :show, id: managed_vessels.first.id if managed_vessels.count == 1

    render locals: {
      grouped_system_parameters: grouped_system_parameters,
      date_range: date_range,
      vessel_group_ids: vessel_group_ids
    }
  end

  def show
    super do
      @vessel_tested_by = vessel_tested_by

      return render locals: {
        vessel: resource,
        date_range: date_range,
        comments: comments,
        charts_data_by_system: charts_data_by_system,
        assigned_date: date_range.end.to_date.beginning_of_month,
        available_systems: available_systems,
        selected_system: selected_system,
        available_parameters: available_parameters,
        selected_parameters: selected_parameters
      }
    end
  end

  private

  def vessel_tested_by
    testers = VesselTestersForDateRangeQuery.call(vessel_id: resource.id, date_range: date_range).pluck(:tested_by)
    return if testers.count > 1

    testers.first
  end

  def managed_vessels
    current_user.managed_vessels
  end

  def comments
    resource.comments
            .where(assigned_date: date_range)
            .order(assigned_date: :desc, created_at: :desc)
  end

  def charts_data_by_system
    VesselChartsDataBySystem.result_for(
      vessel: resource,
      date_range: date_range,
      system: selected_system,
      parameter_ids: selected_parameter_ids
    )
  end

  def date_range
    start_date..end_date
  end

  def end_date
    params[:end_date]&.to_date || start_date.beginning_of_month + 1.month
  end

  def start_date
    params[:start_date]&.to_date || default_start_date
  end

  def default_start_date
    Date.today.beginning_of_month - 1.month
  end

  def vessel_group_ids
    params.fetch(:vessel_group_ids, current_user.vessel_groups.pluck(:id)).map(&:to_i)
  end

  def vessel_ids
    Vessel.joins(:vessel_group).where(vessel_group_id: vessel_group_ids).pluck(:id).uniq
  end

  def grouped_system_parameters
    SystemParametersForVesselIdsQuery.call(vessel_ids: vessel_ids).group_by(&:system)
  end

  def available_systems
    resource.systems
  end

  def selected_system_id
    params[:system_id]
  end

  def selected_system
    return if selected_system_id.blank?

    available_systems.find(selected_system_id)
  end

  def available_parameter_ids
    params = VesselSystemParameter.joins(:vessel_system).select(:parameter_id).distinct.where(vessel_systems: { vessel: resource })
    params = params.where(vessel_systems: { system: selected_system }) unless selected_system.nil?
    params
  end

  def available_parameters
    Parameter.where(id: available_parameter_ids)
  end

  def selected_parameter_ids
    params[:parameter_ids] || available_parameter_ids
  end

  def selected_parameters
    return available_parameters if selected_parameter_ids.blank?

    available_parameters.where(id: selected_parameter_ids)
  end
end
