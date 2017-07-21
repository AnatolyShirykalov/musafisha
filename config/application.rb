require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Musafisha
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec
      g.view_specs false
      g.helper_specs false
      g.feature_specs false
      g.template_engine :slim
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.i18n.locale = :ru
    config.i18n.default_locale = :ru
    config.i18n.available_locales = %i[ru en]
    config.i18n.enforce_available_locales = true
    config.active_record.schema_format = :sql

    config.autoload_paths += %W[#{config.root}/extra]
    config.eager_load_paths += %W[#{config.root}/extra]

    config.time_zone = 'Europe/Moscow'
    config.assets.paths << Rails.root.join(*%w[app assets fonts])
  end
end

