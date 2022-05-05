# frozen_string_literal: true

class VesselsController < BaseController
  def show
    super do
      @metrics_by_system = VesselTrackableMetricsBySystem.result_for(
        vessel: resource,
        start_day: start_day,
        end_day: end_day
      )
    end
  end

  def end_day
    start_day.end_of_month
  end

  def start_day
    Date.today.beginning_of_month - 1.month
  end
end
