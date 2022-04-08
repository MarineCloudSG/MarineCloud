module Trainer
  class TrainingPlansController < BaseController
    belongs_to :client

    def create
      create! { parent }
    end

    protected

    def build_resource_params
      [params.fetch(:training_plan, {}).permit(:name, :description)]
    end
  end
end
