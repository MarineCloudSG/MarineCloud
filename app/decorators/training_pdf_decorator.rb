class TrainingPDFDecorator < ApplicationDecorator
  delegate_all

  decorates_association :superset_exercises, { with: SupersetExercisePDFDecorator }

  def max_series
    @max_series ||= object.superset_exercises.pluck(:repetition_counts, :resistance_values).
      flatten(1).max_by(&:size).size
  end

  def each_superset_exercise
    superset_exercises.group_by(&:superset_id).each_with_index do |(_superset_id, superset_exercises), superset_index|
      superset_exercises.each_with_index do |superset_exercise, exercise_index|
        exercise_number = if superset_exercises.size == 1
                            "#{superset_index+1}"
                          else
                            "#{superset_index+1}#{("A".."Z").to_a[exercise_index]}"
                          end
        yield superset_exercise, exercise_number
      end
    end
  end
end
