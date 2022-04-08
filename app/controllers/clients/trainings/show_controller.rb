module Clients
  module Trainings
    class ShowController < ApplicationController
      def call
        render :template,
               layout: 'training_plan',
               locals: {
                 training: training.decorate,
                 training_plan: training.training_plan.decorate
               }
      end

      private

      def training
        Training.find_by(uid: params.fetch(:uid))
      end
    end
  end
end
