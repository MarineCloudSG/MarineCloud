class TrainingSessionDecorator < ApplicationDecorator
  delegate_all

  def training_name
    object.training.name
  end

  def training_plan_uid
    object.training.training_plan.uid
  end

  def started_on
    I18n.l(object.started_at, format: :date_short)
  end

  def next_exercise_path
    next_exercise_number = object.assigned_exercises.where(done: false).minimum(:number)
    h.clients_assigned_exercise_path(object.training.uid, object.number, next_exercise_number)
  end
end
