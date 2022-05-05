# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  def initialize(title:, description: nil, subheader: nil)
    @title = title
    @description = description
    @subheader = subheader
  end
end
