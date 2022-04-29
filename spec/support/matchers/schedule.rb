CRON_TZ_SUFFIX = %r{ [A-Z]\S*\/[A-Z]\S*$}.freeze

RSpec::Matchers.define :schedule_worker do |worker_class|
  match do |scheduler_entries|
    scheduler_entries.any? do |_name, config|
      config['class'] == worker_class.name &&
        Cronex::ExpressionDescriptor.new(
          config['cron'].sub(CRON_TZ_SUFFIX, '')
        ).description == @cron_expression
    end
  end

  chain :at do |cron_expression|
    @cron_expression = cron_expression
  end
end

RSpec::Matchers.define :schedule_service do |service_class|
  match do |scheduler_entries|
    scheduler_entries.any? do |_name, config|
      config['class'].ends_with?('ServiceWorker') &&
        config['args'].include?(service_class.name.underscore) &&
        puts(
          Cronex::ExpressionDescriptor.new(
            config['cron'].sub(CRON_TZ_SUFFIX, '')
          ).description
        )
        Cronex::ExpressionDescriptor.new(
          config['cron'].sub(CRON_TZ_SUFFIX, '')
        ).description == @cron_expression
    end
  end

  chain :at do |cron_expression|
    @cron_expression = cron_expression
  end
end
