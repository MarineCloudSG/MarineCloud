# frozen_string_literal: true

class TabNavigationComponent < ViewComponent::Base
  include Turbo::FramesHelper

  renders_many :links, -> (label:, icon:, href:) do
    @initial_tab_src ||= href

    TabNavigationLinkComponent.new(
      label: label,
      icon: icon,
      href: href,
      data: { "turbo-frame": @turbo_frame_tag }
    )
  end

  def initialize(turbo_frame_tag:)
    @turbo_frame_tag = turbo_frame_tag
  end
end
