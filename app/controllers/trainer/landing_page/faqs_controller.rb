module Trainer
  module LandingPage
    class FaqsController < BaseController
      def create
        faq = Faq.new(faq_attributes)
        faq_repository.create(faq)

        redirect_to landing_page_faqs_path, status: 303
      end

      def update
        faq = faq_repository.find_by_position(params.fetch(:position))
        faq_repository.move(faq, params.fetch(:new_position))

        redirect_to landing_page_faqs_path, status: 303
      end

      def destroy
        faq = faq_repository.find_by_position(params.fetch(:position))
        faq_repository.destroy(faq)

        redirect_to landing_page_faqs_path, status: 303
      end

      private

      def faq_attributes
        params.fetch(:faq, {}).permit(:question, :answer)
      end

      def collection
        faq_repository.all
      end

      def faq_repository
        @faq_repository ||= Webpages::FaqRepository.new(current_user.webpage)
      end
    end
  end
end
