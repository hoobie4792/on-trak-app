require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OnTrakApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.item_priorities = { 1 => "Very Low", 2 => "Low", 3 => "Medium", 4 => "High", 5 => "Very High" }
    config.sort_options = ["Priority", "Due Date", "Category", "Assigned User"]
  end
end
