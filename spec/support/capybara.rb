require "capybara/rspec"
require "selenium-webdriver"

Capybara.register_driver :remote_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("no-sandbox")
  options.add_argument("headless")
  options.add_argument("disable-gpu")
  options.add_argument("window-size=1680,1050")

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: ENV.fetch("SELENIUM_DRIVER_URL"),
    capabilities: options
  )
end

RSpec.configure do |config|
  # JSなしは rack_test
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  # JSありのみ Selenium
  config.before(:each, type: :system, js: true) do
    driven_by :remote_chrome

    Capybara.server = :puma
    Capybara.server_host = "0.0.0.0"
    Capybara.server_port = 3000   # ← Rails のポート

    Capybara.app_host = "http://web:3000" # ← service名:port
  end
end