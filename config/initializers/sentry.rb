Sentry.init do |config|
  config.dsn = 'https://a411686b2ed44717aeb025365c003975@o1162736.ingest.sentry.io/6384467'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  config.traces_sample_rate = 0.5
  # or
  config.traces_sampler = lambda do |context|
    true
  end
  config.capture_exception_frame_locals = true
  config.excluded_exceptions = [
      'AbstractController::ActionNotFound',
      'ActionController::BadRequest',
      'ActionController::NotImplemented',
      'ActionController::RoutingError',
      'ActionController::UnknownAction',
      'ActionController::UnknownFormat',
      'ActionDispatch::Http::MimeNegotiation::InvalidType',
      'ActionController::UnknownHttpMethod',
      'ActionDispatch::Http::Parameters::ParseError',
    ]
end