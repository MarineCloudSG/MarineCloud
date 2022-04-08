module TrackableMetrics
  class RepetitionsCountDecorator < ApplicationDecorator
    delegate_all

    def trend
      @trend ||= MaximumRepetitionsTrend.result(object)
    end

    def name
      object.exercise&.name || "Undefined"
    end

    def last_value
      "##{trend[trend.keys.max]}"
    end
  end
end
