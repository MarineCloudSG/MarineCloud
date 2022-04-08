module TrackableMetrics
  class MaximumWeightDecorator < ApplicationDecorator
    delegate_all

    def trend
      @trend ||= MaximumWeightTrend.result(object)
    end

    def name
      object.exercise&.name || "Undefined"
    end

    def last_value
      "#{trend[trend.keys.max]} kg"
    end
  end
end
