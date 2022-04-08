class ExerciseProgressTrend < Patterns::Calculation
  def result
    AssignedExercise.
      joins(training_session: [training: :training_plan]).
      where(exercise: subject.exercise).
      where('training_plans.client_id': subject.client_id).
      group('training_sessions.id').
      order('training_sessions.created_at').
      maximum(:actual_repetitions_count).
      values.map(&:to_i)
  end
end
