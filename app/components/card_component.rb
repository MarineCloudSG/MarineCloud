# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  def initialize(title:, description:, link:, icon: nil)
    @title = title
    @description = description
    @icon = icon
    @link = link
  end
end
