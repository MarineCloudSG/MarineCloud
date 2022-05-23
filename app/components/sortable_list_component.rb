# frozen_string_literal: true

class SortableListComponent < ViewComponent::Base
  with_collection_parameter :resource

  def initialize(resource:, route:, resource_iteration:)
    @resource = resource
    @route = route
    @iteration = resource_iteration
  end

  def resource
    @resource
  end

  def move_up_link
    link_to helpers.public_send("#{@route}_path", @resource.position, new_position: @resource.position - 1),
            class: "inline-flex items-center p-1 border border-transparent rounded-full shadow-sm text-white bg-sky-600 hover:bg-sky-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-sky-500",
            data: { 'turbo-method' => :put } do
      helpers.heroicon("chevron-up", options: { class: "h-5 w-5", disable_default_class: true })
    end
  end

  def move_down_link
    link_to helpers.public_send("#{@route}_path", @resource.position, new_position: @resource.position + 1),
            class: "inline-flex items-center p-1 border border-transparent rounded-full shadow-sm text-white bg-sky-600 hover:bg-sky-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-sky-500",
            data: { 'turbo-method' => :put } do
      helpers.heroicon("chevron-down", options: { class: "h-5 w-5", disable_default_class: true })
    end
  end

  def remove_link
    link_to helpers.public_send("#{@route}_path", @resource.position),
            class: "inline-flex items-center p-1 border border-transparent rounded-full shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500",
            data: { 'turbo-method' => :delete } do
      helpers.heroicon("trash", options: { class: "h-5 w-5", disable_default_class: true })
    end
  end
end
