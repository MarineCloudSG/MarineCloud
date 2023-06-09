# frozen_string_literal: true

Heroicon.configure do |config|
  config.variant = :outline # Options are :solid and :outline

  # You can set a default class, which will get applied to every icon with
  # the given variant. To do so, un-comment the line below.
  config.default_class = {
    solid: "h-5 w-5",
    outline: "text-gray-400 group-hover:text-gray-500 flex-shrink-0 -ml-1 mr-3 h-6 w-6"
  }
end
