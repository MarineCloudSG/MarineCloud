# frozen_string_literal: true

class MenuLinksComponent < ViewComponent::Base
  renders_many :links, -> (label:, url:, controllers:, vessel_group_id: nil) do
    vessel_group_params = request.params[:vessel_group_ids] || []
    extra_classes = if controller_name.in?(Array.wrap(controllers)) && ((vessel_group_id.nil? && vessel_group_params.empty?) || vessel_group_params.include?(vessel_group_id))
                      @classes_current
                    else
                      @classes_default
                    end

    link_to label, url, class: "#{@classes_base} #{extra_classes}"
  end

  def initialize(classes_current:, classes_default:, classes_base:)
    @classes_current = classes_current
    @classes_default = classes_default
    @classes_base = classes_base
  end

  def controller_name
    controller.class.name.chomp('Controller').underscore
  end
end
