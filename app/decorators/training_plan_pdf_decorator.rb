class TrainingPlanPDFDecorator < ApplicationDecorator
  delegate_all

  def file_name
    I18n.transliterate(object.name.downcase).gsub(' ', '_')
  end

  decorates_association :trainings, with: TrainingPDFDecorator
end
