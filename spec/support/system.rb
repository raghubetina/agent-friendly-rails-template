Capybara.server = :puma, {silent: true}
Capybara.default_max_wait_time = 5
Capybara.save_path = Rails.root.join("tmp/capybara")

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by(:rack_test)
  end

  config.before(:each, type: :system, js: true) do
    driven_by(:selenium, using: :headless_chrome, screen_size: [1400, 1400]) do |options|
      options.add_argument("--disable-dev-shm-usage")
      options.add_argument("--no-sandbox")
    end
  end
end
