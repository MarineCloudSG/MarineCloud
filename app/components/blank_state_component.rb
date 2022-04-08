# frozen_string_literal: true

class BlankStateComponent < ViewComponent::Base
  def initialize(title:, url:)
    @title = title
    @url = url
  end
end
