# frozen_string_literal: true

class StackedListElementComponent < ViewComponent::Base
  def initialize(title:, description:, annotation:, url:)
    @title = title
    @description = description
    @annotation = annotation
    @url = url
  end
end
