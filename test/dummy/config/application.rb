require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "table_locks"

module Dummy
  class Application < Rails::Application
    if Rails::VERSION::MAJOR >= 5
      config.load_defaults Rails::VERSION::STRING.to_f
    else
      # Fallback behavior for releases prior to Rails 5
      config.active_record.raise_in_transactional_callbacks = true
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
