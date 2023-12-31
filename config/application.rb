require_relative "boot"

require "rails"
require "active_job/railtie"
require "action_controller/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SocialNetwork
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    config.time_zone = "UTC"

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.sequel.schema_dump = true
    config.sequel.schema_format = :sql

    if defined?(Rake.application)  && Rake.application.top_level_tasks.include?('sequel:create')
      config.sequel.skip_connect = true
    end

    config.sequel.after_connect = proc do
      Sequel.default_timezone = :utc

      ::DB = Sequel::Model.db unless Object.const_defined?(:DB)
      Sequel::Model.plugin :timestamps, update_on_create: true, allow_manual_update: true
      Sequel::Model.plugin :insert_returning_select
    end
  end
end
