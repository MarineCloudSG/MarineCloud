source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

# Use main development branch of Rails
gem "rails"

gem "activeadmin"
gem 'sassc'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire"s SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire"s modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Controller simplifications
gem "inherited_resources"

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Pagination
gem "kaminari"

# Active Storage
# gem "aws-sdk-s3"

# Authentication
gem "devise"
# gem "omniauth-rails_csrf_protection"
# gem "omniauth-google-oauth2"
# gem "omniauth-facebook"

# Decorators
gem "draper"

# DRY package
gem "dry-rails", "~> 0.1"

# Design patterns
gem "rails-patterns"

# Asynchronous processing
gem "sidekiq", "~> 5.2.1"
gem "sidekiq-cron", "~> 1.0.4"
gem "sidekiq-status"

# REST APIs
# gem "graphiti"
# gem "graphiti-rails", "~> 0.1"

# Authorization
gem "pundit"

# charts for trackable metrics
gem "chartkick"

# Pub/Sub support
gem "pubsub_on_rails", "~> 0.0.7"

# View components
gem "view_component"
# TODO: Revert to official version after next release. We were eager to use error_message helper
gem "view_component-form", github: "pantographe/view_component-form", ref: "f06cd2b"

# Icons for TailwindUI
gem "heroicon"

# Initials from string
gem "initials"

# Pdf generation
# gem 'wicked_pdf', github: 'mileszs/wicked_pdf', ref: 'bc73252' # PDF from HTML # PDF from HTML
# gem 'wkhtmltopdf-heroku', '2.12.5.0' # For Heroku Stack 18 (Ubuntu 18.04)
gem 'grover' #probably better PDF from HTML generator

# Patterns
gem "rails-patterns"

# Spreadsheets support
gem "roo"

# sentry
gem "sentry-ruby"
gem "sentry-rails"

# new relic
gem "newrelic_rpm"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # RSpec + FactoryBot as testing framework of choice
  gem "factory_bot_rails"
  gem "factory_trace"
  gem "rspec-rails"
  # Ensure uniform code style
  gem "rubocop", "~> 1.16.0", require: false
  gem "dotenv-rails"
end

group :test do
  # Spec helpers
  gem "rspec-tapas", "~> 0.2.1"
  # gem "graphiti_spec_helpers"

  # Mocking HTTP requests
  gem "webmock"

  # Stubbing environment variables
  gem "stub_env"

  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"

  # Coverage reports
  gem "simplecov", require: false

  gem "cronex"

  gem "faker"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Handling emails in local development environment
  gem "letter_opener"

  # favicon generating
  gem 'rails_real_favicon'
end
