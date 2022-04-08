module Hints
  class Exercise
    attr_reader :position

    delegate :muscle_group_ids, to: :exercise

    def initialize(exercise_id:, position:)
      @exercise_id = exercise_id
      @position = position
    end

    private

    attr_reader :exercise_id

    def exercise
      @exercise ||= ::Exercise.find(exercise_id)
    end
  end
end
