module Hints
  class Superset
    def initialize(position:, superset:, exercises_attributes:)
      @position = position
      @superset = superset
      @exercises_attributes = exercises_attributes
    end

    def exercises
      exercises_attributes.map do |exercise_attributes|
        Exercise.new(
          exercise_id: exercise_attributes.fetch(:id),
          position: "#{position}.#{exercise_attributes.fetch(:position)}"
        )
      end
    end

    private

    attr_reader :position, :superset, :exercises_attributes
  end
end
