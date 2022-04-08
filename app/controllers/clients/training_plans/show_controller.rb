module Clients
  module TrainingPlans
    class ShowController < ApplicationController
      def call
        respond_to do |format|
          format.html { redirect_to(clients_training_path(uid: training.uid)) }
          format.pdf do
            training_plan_decorated = TrainingPlanPDFDecorator.decorate(training_plan)
            html = render_to_string(template: 'clients/training_plans/show/call', layout: 'training_plan', locals: { training_plan: training_plan_decorated})
            pdf = Grover.new(html).to_pdf
            send_data(pdf, filename: training_plan_decorated.file_name, type: 'application/pdf')
          end
        end
      end

      private

      def training
        NextTraining.result_for(training_plan)
      end

      def training_plan
        TrainingPlan.find_by!(uid: params.fetch(:uid))
      end
    end
  end
end
