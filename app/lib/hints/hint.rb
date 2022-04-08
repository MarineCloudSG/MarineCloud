module Hints
  class Hint
    attr_reader :references

    def initialize(reference_group, rule)
      @references = reference_group
      @rule = rule
    end

    def text
      I18n.translate(translation_key)
    end

    private

    attr_reader :rule

    def translation_key
      "hints.rules.#{rule.class.name.demodulize.underscore}"
    end
  end
end
