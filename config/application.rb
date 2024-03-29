require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cogumelos
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.time_zone = "Brasilia"
    config.encoding = "utf-8"
    config.load_defaults 7.0
    I18n.available_locales = %i[pt-BR]
    I18n.default_locale = :"pt-BR"
    config.generators.system_tests = nil

    def ransackable_associations(auth_object = nil)
      Rails.logger.info("WITHIN RANSACK ASSOCIATION")
      super + %w[impressionable]
    end    
  end
end
