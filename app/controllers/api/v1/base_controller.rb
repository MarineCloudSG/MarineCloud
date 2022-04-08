module Api
  module V1
    class BaseController < ActionController::Base
      include Dry::Rails::Features::SafeParams
      include Pundit

      before_action :authenticate_user!
      before_action :validate_params!

      private

      def handle_bad_request
        head 400
      end

      def validate_params!
        render(json: safe_params.errors.to_h, status: :bad_request) if safe_params&.failure?
      end

      def self.request_schema(&block)
        schema(:call, &block)
      end
      private_class_method :request_schema
    end
  end
end
