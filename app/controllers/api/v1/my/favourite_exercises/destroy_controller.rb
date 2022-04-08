module Api
  module V1
    module My
      module FavouriteExercises
        class DestroyController < BaseController
           skip_forgery_protection
          def call
            current_user.
              exercise_favourites.
              where(exercise_id: params.fetch(:exercise_id)).
              destroy_all
          end
        end
      end
    end
  end
end
