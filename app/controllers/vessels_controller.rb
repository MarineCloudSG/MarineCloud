# frozen_string_literal: true

class VesselsController < BaseController
  def show
    super do
      @metrics_by_system = VesselTrackableMetricsBySystem.result_for(
        vessel: resource,
        start_date: start_date,
        end_date: end_date
      )
    end
  end

  def end_date
    start_date.end_of_month
  end

  def start_date
    Date.today.beginning_of_month - 1.month
  end
end
