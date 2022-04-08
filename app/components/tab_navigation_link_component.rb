# frozen_string_literal: true

class TabNavigationLinkComponent < ViewComponent::Base
  def initialize(label:, icon:, href:, data: {})
    @label = label
    @icon = icon
    @href = href
    @data = data.merge("tab-navigation-component-target": "link")
  end

  def call
    link_to @href, class: classes, data: @data do
      icon << content_tag(:span, @label, class: "truncate")
    end
  end

  private

  def icon
    helpers.heroicon @icon
  end

  def classes
    "text-gray-900 hover:text-gray-900 hover:bg-gray-50 group rounded-md px-3 py-2 flex items-center text-sm font-medium"
  end
end
