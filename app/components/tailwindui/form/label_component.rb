# frozen_string_literal: true

class TailwindUI::Form::LabelComponent < ViewComponent::Form::LabelComponent
  def html_class
    class_names("block text-sm font-medium text-gray-700")
  end
end
