require 'capybara/poltergeist'
require 'capybara/angular'

require 'phantomjs'

module FakePoltergeistLogger
  def self.puts(*)
  end
end

Capybara.register_driver :poltergeist do |app|
  options = {
    phantomjs:        Phantomjs.path,
    js_errors:        false,
    phantomjs_logger: FakePoltergeistLogger
  }

  Capybara::Poltergeist::Driver.new app, options
end

Capybara.default_driver = :poltergeist

Capybara::Angular.default_max_wait_time = 10
