# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  def initialize(title:, description: nil)
    @title = title
    @description = description
  end
end
