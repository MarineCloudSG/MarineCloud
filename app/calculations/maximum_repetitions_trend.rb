class MaximumRepetitionsTrend < Patterns::Calculation
  def result
    AssignedExercise.
      joins(training_session: [training: :training_plan]).
      where(exercise: subject.exercise_id).
      where('training_plans.client_id': subject.client_id).
      group('training_sessions.created_at').
      order('training_sessions.created_at').
      maximum(:actual_repetitions_count).
      each_with_object({}) do |(key, value), hash|
        hash[key.to_date.iso8601] = value.to_i
    end
  end
end
