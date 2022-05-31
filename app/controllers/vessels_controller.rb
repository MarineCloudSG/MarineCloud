# frozen_string_literal: true

class VesselsController < BaseController
  def index
    render locals: {
      system_parameters: system_parameters,
      date_range: date_range,
      vessel_group_ids: vessel_group_ids
    }
  end

  def show
    super do
      return render locals: {
        vessel: resource,
        date_range: date_range,
        comments: comments,
        metrics_by_system: metrics_by_system
      }
    end
  end

  private

  def comments
    resource.comments.order(year: :desc, month: :desc, created_at: :desc)
  end

  def metrics_by_system
    VesselTrackableMetricsBySystem.result_for(
      vessel: resource,
      date_range: date_range
    )
  end

  def date_range
    start_date..end_date
  end

  private

  def end_date
    params.fetch(:end_date, start_date.end_of_month).to_date
  end

  def start_date
    params.fetch(:start_date, Date.today.beginning_of_month - 1.month).to_date
  end

  def vessel_group_ids
    params.fetch(:vessel_group_ids, current_user.vessel_groups.pluck(:id)).map(&:to_i)
  end

  def vessel_ids
    Vessel.joins(:vessel_group).where(vessel_group_id: vessel_group_ids).pluck(:id).uniq
  end

  def system_parameters
    SystemParametersForVesselIdsQuery.call(vessel_ids: vessel_ids)
                                     .map { |vsp| [vsp.system, vsp.parameter] }
                                     .uniq
  end
end
