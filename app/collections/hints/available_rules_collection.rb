module Hints
  class AvailableRulesCollection
    include Enumerable

    def initialize; end

    def each
      yield Rules::AvoidSameMuscleGroupInSingleSuperset
    end
  end
end
