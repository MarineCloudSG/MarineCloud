# frozen_string_literal: true

class VesselsController < BaseController
  def show
    render locals: {
      vessel: resource,
      date_range: start_date..end_date,
      comments: comments,
      metrics_by_system: metrics_by_system
    }
  end

  private

  def comments
    resource.comments.order(year: :desc, month: :desc, created_at: :desc)
  end

  def metrics_by_system
    VesselTrackableMetricsBySystem.result_for(
      vessel: resource,
      start_date: start_date,
      end_date: end_date
    )
  end

  def end_date
    start_date.end_of_month
  end

  def start_date
    Date.today.beginning_of_month - 1.month
  end
end
