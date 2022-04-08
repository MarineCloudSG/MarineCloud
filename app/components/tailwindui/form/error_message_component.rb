# frozen_string_literal: true

class TailwindUI::Form::ErrorMessageComponent < ViewComponent::Form::ErrorMessageComponent
  def html_class
    class_names("mt-2 text-sm text-red-600")
  end
end
