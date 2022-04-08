module Clients
  module AssignedExercises
    class ShowController < ApplicationController
      def call
        render :template,
               layout: 'training_plan',
               locals: {
                 training: training,
                 training_session: training_session,
                 assigned_exercise: assigned_exercise.decorate
               }
      end

      private

      def training_session
        training.sessions.find_by!(number: session_no)
      end

      def training
        Training.find_by!(uid: params.fetch(:training_uid)).decorate
      end

      def assigned_exercise
        assigned_exercises.get_by_number(exercise_no)
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
