class CreateTrainingSession < Patterns::Service
  def initialize(training)
    @training = training
  end

  def call
    assign_exercises
    cache_exercise_count
  end

  private

  attr_reader :training

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def assign_exercises
    position = 1
    training.supersets.order(position: :asc).each do |superset|
      superset.series_count.times do |series|
        superset.superset_exercises.order(position: :asc).each do |superset_exercise|
          training_session.assigned_exercises.create(
            exercise: superset_exercise.exercise,
            position: position,
            current_series: series + 1,
            superset_series_count: superset.series_count,
            notes: superset_exercise.notes,
            repetitions_count: superset_exercise.repetition_counts[series],
            resistance_value: superset_exercise.resistance_values[series]
          )
          position += 1
        end
      end
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def cache_exercise_count
    training_session.update_column(:exercise_count, training_session.assigned_exercises.count)
  end

  def training_session
    @training_session ||= TrainingSession.create(
      training: training,
      number: (training.sessions.maximum(:number) || 0) + 1
    )
  end
end
