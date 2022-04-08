# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  def initialize(type:)
    @type = type
    # @icon_class = icon_class
    # @icon_color_class = icon_color_class
  end

  private

  # def icon_class
  #   case @type
  #   when 'success'
  #     'fa-check-circle'
  #   when 'error'
  #     'fa-exclamation-triangle'
  #   when 'alert'
  #     'fa-exclamation-circle'
  #   else
  #     'fa-info-circle'
  #   end
  # end
  #
  # def icon_color_class
  #   case @type
  #   when 'success'
  #     'text-green-400'
  #   when 'error'
  #     'text-red-800'
  #   when 'alert'
  #     'text-red-400'
  #   else
  #     'text-gray-400'
  #   end
  # end
end
