require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Artisttracker
  class Application < Rails::Application

    # config.autoload_paths += %W(#{config.root}/lib/*)
    config.autoload_paths += %W(#{config.root}/lib/
                                #{config.root}/services/
                                #{config.root}/app/jobs)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.initialize_on_precompile=false

    # Uncomment this config if you want to see logs for asset rendering.
    # Logging of assets is turned off by default in development environment.
    # config.quiet_assets = false
  end
end
