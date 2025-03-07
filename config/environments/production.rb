# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.assets.compile = false
  config.assets.digest = true
  config.hosts << 'gstonehill.xyz'
  config.action_controller.default_url_options = { protocol: 'https', host: 'gstonehill.xyz' }

  # Settings specified here will take precedence over those in config/application.rb.

  # In the production environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = true

  # Do not eager load code on boot.
  config.eager_load = true

  # Show full error reports.
  config.consider_all_requests_local = false

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  config.action_controller.perform_caching = true
  config.action_controller.enable_fragment_cache_logging = true

  config.cache_store = :memory_store
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{2.days.to_i}"
  }
  config.public_file_server.enabled = true

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  host = 'gstonehill.xyz'
  config.action_mailer.default_url_options = { host:, protocol: 'http' }

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # Gmail設定
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  host = 'gstonehill.xyz'
  config.action_mailer.default_url_options = { host:, protocol: 'https' }
  config.action_mailer.perform_caching = false

  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gstonehill.xyz',
    user_name: ENV['GMAIL_USERNAME'], # 環境変数を使用
    password: ENV['GMAIL_PASSWORD'], # 環境変数を使用
    authentication: 'plain',
    enable_starttls_auto: true
  }

  # 環境変数を読み込むための設定
  Dotenv::Rails.load if defined?(Dotenv)

  # Mailgunの設定をコメントアウト
  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.delivery_method = :smtp
  # host = 'https://your-domain.com'
  # config.action_mailer.default_url_options = { host: host }
  # ActionMailer::Base.smtp_settings = {
  #   :port           => 587,
  #   :address        => 'smtp.mailgun.org',
  #   :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
  #   :password       => ENV['MAILGUN_SMTP_PASSWORD'],
  #   :domain         => host,
  #   :authentication => :plain,
  # }

  # AWSの設定をコメントアウト
  # config.active_storage.service = :amazon
end
