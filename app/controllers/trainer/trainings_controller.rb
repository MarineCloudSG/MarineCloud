module Trainer
  class TrainingsController < BaseController
    nested_belongs_to :client, :training_plan

    def create
      create! { [:edit, parent.client, parent, resource] }
    end

    protected

    def build_resource_params
      [params.fetch(:training, {}).permit(:name, :description)]
    end
  end
end
