module Api
  module V1
    module Trainings
      class ShowController < BaseController
        def call
          authorize training, :show?

          if requesting_draft? && training.draft.present?
            render json: training.draft.data.merge(draft: true)
          else
            render json: { draft: false, data: TrainingDataSerializer.dump(training) }
          end
        end

        private

        def requesting_draft?
          ActiveModel::Type::Boolean.new.cast(params[:draft])
        end

        def training
          @training ||= Training.find(params[:id])
        end
      end
    end
  end
end
