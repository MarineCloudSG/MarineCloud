class TrainingSessionExercisesCollection
  def initialize(training_uid:, session_no:)
    @training_uid = training_uid
    @session_no = session_no
  end

  def each(&block)
    training_session.assigned_exercises.each(&block)
  end

  def get_by_number(number)
    training_session.assigned_exercises.find_by!(number: number)
  end

  private

  attr_reader :training_uid, :session_no

  def training_session
    training.sessions.find_by!(number: session_no)
  end

  def training
    Training.find_by!(uid: training_uid)
  end
end
