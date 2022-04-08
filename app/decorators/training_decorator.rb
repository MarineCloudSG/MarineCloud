class TrainingDecorator < ApplicationDecorator
  delegate_all

  def last_session_at
    if object.sessions.where(done: true).present?
      "Last session: #{I18n.l(object.sessions.where(done: true).maximum(:started_at), format: :date_short)}"
    end
  end

  def plan_name
    object.training_plan.name
  end

  def next_training_path
    next_training = trainings.where('created_at > ?', object.created_at).first || trainings.first
    h.clients_training_path(uid: next_training.uid)
  end

  def previous_training_path
    previous_training = trainings.where('created_at < ?', object.created_at).last || trainings.last
    h.clients_training_path(uid: previous_training.uid)
  end

  private

  def trainings
    object.training_plan.trainings
  end
end
