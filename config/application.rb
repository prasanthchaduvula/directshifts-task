# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DirectshiftsTask
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.

    config.generators do |g|
      g.test_framework :test_unit, fixture: false
    end

    config.react.server_renderer_extensions = ["jsx", "js", "tsx", "ts"]

    if (email_delivery_method = ENV["EMAIL_DELIVERY_METHOD"])
      config.action_mailer.delivery_method = email_delivery_method.to_sym
    end

    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
