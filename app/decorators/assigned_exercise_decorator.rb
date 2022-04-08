class AssignedExerciseDecorator < ApplicationDecorator
  delegate_all

  def name
    object.exercise.name
  end

  def last?
    object.training_session.exercise_count == object.number
  end
end
