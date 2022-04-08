module Trainer
  module My
    class ProfilesController < BaseController
      def update
        update! { edit_my_profile_path }
      end

      private

      def resource
        current_user
      end

      def build_resource_params
        [params.fetch(:user, {}).permit(:language)]
      end
    end
  end
end
