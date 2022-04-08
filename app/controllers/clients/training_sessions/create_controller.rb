module Clients
  module TrainingSessions
    class CreateController < ApplicationController
      def call
        CreateTrainingSession.call(training)

        redirect_to clients_assigned_exercise_path(
                      training_uid: params.fetch(:uid),
                      session_no: training_session.number,
                      exercise_no: 1
                    )
      end

      private

      def training_session
        training.sessions.last
      end

      def training
        Training.find_by!(uid: params.fetch(:uid))
      end
    end
  end
end
