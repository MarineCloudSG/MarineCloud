module TrackableMetrics
  class TrainingVolumeDecorator < ApplicationDecorator
    delegate_all

    def trend
      TrainingVolumeTrend.result(object)
    end

    def name
      "Training volume"
    end

    def last_value
      "TBD"
    end
  end
end
