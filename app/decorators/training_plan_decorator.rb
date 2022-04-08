class TrainingPlanDecorator < ApplicationDecorator
  delegate_all

  decorates_association :trainings

  def any_session_is_active?
    active_session.present?
  end

  def active_session
    @active_session ||= object.sessions.where(done: false).first&.decorate
  end
end
