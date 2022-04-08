class NextTraining < Patterns::Calculation
  def result
    result = last_training.present? && trainings.
             where('created_at > ?', last_training.created_at).first
    result ||= trainings.first
    result
  end

  private

  alias_method :training_plan, :subject

  def trainings
    training_plan.trainings.order(created_at: :asc)
  end

  def last_training
    @last_training ||= TrainingSession.
                       joins(training: :training_plan).
                       where(training_plans: { id: training_plan.id }).
                       order('training_sessions.created_at' => :desc).
                       first&.training
  end
end
