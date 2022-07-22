# https://docs.sentry.io/platforms/ruby/guides/rails/?_ga=2.167667262.1426846397.1658491703-1585621489.1658491703
# https://github.com/ianmitchell/sentrydiscord.dev
# https://docs.sentry.io/platforms/ruby/guides/rails/configuration/options/

Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
  config.environment = 'production'
end
