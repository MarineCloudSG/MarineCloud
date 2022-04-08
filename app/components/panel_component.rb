# frozen_string_literal: true

class PanelComponent < ViewComponent::Base
  renders_many :links

  def initialize(title:)
    @title = title
  end
end
