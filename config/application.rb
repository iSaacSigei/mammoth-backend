require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MammothBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:4000', 'https://mammoth-deploy-2-production.up.railway.app'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
      end
    end
    

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_myapp_session', expire_after: 14.days, httponly: true, secure: Rails.env.production?
    config.session_store :cookie_store, key: '_myapp_session', domain: :all

  end
end
