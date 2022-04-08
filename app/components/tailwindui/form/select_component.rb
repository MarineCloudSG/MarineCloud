# frozen_string_literal: true

class TailwindUI::Form::SelectComponent < ViewComponent::Form::SelectComponent
  def html_class
    class_names(
      "mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full border-gray-300 shadow-sm sm:text-sm rounded-md",
      "border-red-300 text-red-900 placeholder-red-300": method_errors?
    )
  end
end
