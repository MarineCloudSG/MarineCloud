# frozen_string_literal: true

class TailwindUI::Form::TextFieldComponent < ViewComponent::Form::TextFieldComponent
  def html_class
    class_names(
      "mt-1 focus:ring-sky-500 focus:border-sky-500 block w-full border-gray-300 shadow-sm sm:text-sm rounded-md",
      "border-red-300 text-red-900 placeholder-red-300": method_errors?
    )
  end
end
