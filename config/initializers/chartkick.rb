require 'active_support/core_ext/module/aliasing'

module ChartkickMixinJavascriptFunctions
  FUNCTION_NAME_DELIMITER = 'FNNAME'

  module Helper
    def js_function_name(fn)
      "#{ChartkickMixinJavascriptFunctions::FUNCTION_NAME_DELIMITER}#{fn}"
    end

    private
    def chartkick_chart(klass, data_source, options)
      rendered = super(klass, data_source, **options)

      rendered
        .gsub(/"#{ChartkickMixinJavascriptFunctions::FUNCTION_NAME_DELIMITER}([^""]*)"/, '\1')
        .gsub('\"', '"')
        .html_safe
    end

  end
end

Chartkick::Helper.send(:prepend, ChartkickMixinJavascriptFunctions::Helper)
