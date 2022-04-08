module Api
  module V1
    module My
      module FavouriteExercises
        class CreateController < BaseController
          skip_forgery_protection

          def call
            current_user.favourite_exercises << Exercise.find(params.fetch(:exercise_id))
          end
        end
      end
    end
  end
end
