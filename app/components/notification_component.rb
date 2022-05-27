# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  def initialize(type:)
    @type = type
    @icon_class = icon_class
    @icon_color_class = icon_color_class
    @background_class = background_class
    @text_color = text_color
  end

  private

  def icon_class
    case @type
    when 'success'
      'fa-check-circle'
    when 'error'
      'fa-exclamation-triangle'
    when 'alert'
      'fa-exclamation-circle'
    else
      'fa-info-circle'
    end
  end

  def icon_color_class
    case @type
    when 'success'
      'text-green-400'
    when 'error'
      'text-red-800'
    when 'alert'
      'text-orange-600'
    else
      'text-gray-400'
    end
  end

  def background_class
    case @type
    when 'success'
      'bg-green-50'
    when 'error'
      'bg-red-200'
    when 'alert'
      'bg-orange-100'
    else
      'bg-gray-400'
    end
  end
  def text_color
    case @type
    when 'success'
      'text-green-800'
    when 'error'
      'text-red-800'
    when 'alert'
      'text-orange-600'
    else
      'text-gray-800'
    end
  end
end
