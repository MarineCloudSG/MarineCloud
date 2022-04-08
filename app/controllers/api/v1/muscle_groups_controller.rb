module Api
  module V1
    class MuscleGroupsController < ApplicationController
      respond_to :jsonapi

      def index
        muscle_groups = MuscleGroupResource.all(params)
        respond_with(muscle_groups)
      end
    end
  end
end
