module Clients
  module AssignedExercises
    class UpdateController < ApplicationController
      def call
        assigned_exercise.assign_attributes(assigned_exercise_params)
        assigned_exercise.save!

        if assigned_exercise.last?
          assigned_exercise.training_session.update_attribute(:done, true)
          render :well_done, layout: 'training_plan', locals: {
            training_session: assigned_exercise.training_session.decorate
          }
        else
          redirect_to next_exercise_path
        end
      end

      private

      def assigned_exercise_params
        params.fetch(:assigned_exercise, {}).
          permit(:actual_repetitions_count, :actual_resistance_value, :done)
      end

      def next_exercise_path
        clients_assigned_exercise_path(params.fetch(:training_uid), session_no, exercise_no + 1)
      end

      def assigned_exercise
        @assigned_exercise ||= assigned_exercises.get_by_number(exercise_no).decorate
      end

      def session_no
        params.fetch(:session_no).to_i
      end

      def exercise_no
        params.fetch(:exercise_no).to_i
      end

      def assigned_exercises
        TrainingSessionExercisesCollection.new(
          training_uid: params.fetch(:training_uid),
          session_no: session_no
        )
      end
    end
  end
end
