module Hints
  class SupersetsCollection
    include Enumerable

    def initialize(training_data)
      @training_data = training_data
    end

    def each
      training_data.each do |superset_attributes|
        yield Superset.new(
          position: superset_attributes.fetch(:position),
          superset: superset_attributes.fetch(:superset),
          exercises_attributes: superset_attributes.fetch(:exercises)
        )
      end
    end

    private

    attr_reader :training_data
  end
end
