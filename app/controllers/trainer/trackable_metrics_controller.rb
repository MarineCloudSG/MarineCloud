module Trainer
  class TrackableMetricsController < BaseController
    belongs_to :client

    def new
      render :new, locals: { trackable_metric_classes: TrackableMetric.descendants }
    end

    def create
      create! { edit_client_trackable_metric_path(parent, resource) }
    end

    def update
      update! { client_path(parent) }
    end

    private

    def build_resource_params
      if params[:action] == 'create'
        [params.fetch(:trackable_metric, {}).permit(:type)]
      else
        [params.fetch(:trackable_metric, {}).permit(:exercise_id, :training_id)]
      end
    end
  end
end
