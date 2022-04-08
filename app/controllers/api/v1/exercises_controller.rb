module Api
  module V1
    class ExercisesController < BaseController
      respond_to :jsonapi

      def index
        exercises = ExerciseResource.all(params)
        respond_with(exercises)
      end

      def show
        exercise = ExerciseResource.find(params)
        respond_with(exercise)
      end

      def create
        exercise = ExerciseResource.build(params)

        if exercise.save
          render jsonapi: exercise, status: 201
        else
          render jsonapi_errors: exercise
        end
      end

      def update
        exercise = ExerciseResource.find(params)

        if exercise.update_attributes
          render jsonapi: exercise
        else
          render jsonapi_errors: exercise
        end
      end

      def destroy
        exercise = ExerciseResource.find(params)

        if exercise.destroy
          render jsonapi: { meta: {} }, status: 200
        else
          render jsonapi_errors: exercise
        end
      end
    end
  end
end
