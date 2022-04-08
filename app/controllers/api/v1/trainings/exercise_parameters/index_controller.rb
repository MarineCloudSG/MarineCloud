module Api
  module V1
    module Trainings
      module ExerciseParameters
        class IndexController < BaseController
          def call
            render json: { data: parameters }
          end

          private

          def parameters
            exercise.parameters.map do |parameter|
              {
                field: parameter.field,
                default: parameter.default,
                source: 'default'
              }
            end
          end

          def exercise
            Exercise.find(params.fetch(:exercise_id))
          end
        end
      end
    end
  end
end
