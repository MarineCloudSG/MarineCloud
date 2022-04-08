module Api
  module V1
    module Trainings
      module Hints
        class IndexController < BaseController
          def call
            hints = hints_collection.map do |hint|
              {
                text: hint.text,
                references: hint.references
              }
            end

            render json: { data: hints }
          end

          private

          def hints_collection
            ::Hints::HintsCollection.new(
              training_data: training_data,
              profile_data: profile_data,
              available_rules: available_rules
            )
          end

          def available_rules
            ::Hints::AvailableRulesCollection.new
          end

          def training_data
            TrainingDataSerializer.dump(training)
          end

          def profile_data
            ProfileDataSerializer.dump(client)
          end

          def training
            @training ||= Training.find(params.fetch(:training_id))
          end

          def client
            training.training_plan.client
          end
        end
      end
    end
  end
end
