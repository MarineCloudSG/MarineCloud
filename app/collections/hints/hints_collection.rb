module Hints
  class HintsCollection
    include Enumerable

    attr_reader :available_rules, :training_data, :profile_data

    def initialize(training_data:, profile_data:, available_rules:)
      @available_rules = available_rules
      @training_data = training_data
      @profile_data = profile_data
    end

    def each
      available_rules_instances.each do |rule|
        rule.references.each do |reference_group|
          yield Hint.new(reference_group, rule)
        end
      end
    end

    private

    def available_rules_instances
      available_rules.map do |rule_klass|
        rule_klass.new(training_data, profile_data)
      end
    end
  end
end
