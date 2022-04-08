module Api
  module V1
    module Trainings
      class UpdateController < BaseController
        skip_forgery_protection
        rescue_from PG::NotNullViolation, with: :handle_bad_request

        request_schema do
          required(:id).value(:integer)
          required(:data).array(:hash) do
            required(:position).value(:integer)
            required(:superset).value(:bool)
            required(:seriesCount).value(:integer, gt?: 0)
            required(:exercises).array(:hash) do
              required(:id).value(:integer)
              required(:position).value(:integer)
              required(:notes).maybe(:string)
              required(:tempo).maybe(:string)
              required(:configuration).hash do
                optional(:weight).array(:string)
                optional(:repetitions).array(:string)
              end
            end
          end
        end

        # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        def call
          authorize training, :update?

          if requesting_draft?
            training_draft = TrainingDraft.where(training_id: params[:id]).first_or_initialize
            training_draft.update_attribute(:data, { data: params.fetch(:data) })

            render json: { draft: true, data: params.fetch(:data) }
          else
            Training.transaction do
              training.draft&.destroy!
              training.supersets.destroy_all

              supersets_params.each do |superset_attributes|
                superset = training.supersets.create!(
                  superset_attributes.slice(:position, :series_count)
                )

                superset_attributes.fetch(:exercises).each do |superset_exercise_attributes|
                  superset.superset_exercises.create!(
                    exercise_id: superset_exercise_attributes.fetch(:id),
                    tempo: superset_exercise_attributes.fetch(:tempo),
                    notes: superset_exercise_attributes.fetch(:notes),
                    position: superset_exercise_attributes.fetch(:position),
                    resistance_values: superset_exercise_attributes.fetch(:configuration).
                      fetch(:weight, []),
                    repetition_counts: superset_exercise_attributes.fetch(:configuration).
                      fetch(:repetitions, [])
                  )
                end
              end
            end

            render json: { draft: false, data: TrainingDataSerializer.dump(training) }
          end
        end
        # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

        private

        def requesting_draft?
          ActiveModel::Type::Boolean.new.cast(params[:draft])
        end

        def supersets_params
          params.to_unsafe_hash.
            deep_transform_keys(&:underscore).
            deep_symbolize_keys.
            fetch(:data)
        end

        def training
          @training ||= Training.find(params[:id])
        end
      end
    end
  end
end
