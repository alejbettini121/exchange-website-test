# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
ENV["ADMIN"] ||= 'admin@peatio.dev'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/poltergeist'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
    js_errors: false,
    debug: false,
    logger: nil,
    phantomjs_logger: nil,
    window_size: [1440, 900]
  })
end

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner.start

    Rails.cache.clear
    AMQPQueue.stubs(:publish)
    KlineDB.stubs(:kline).returns([])

    I18n.locale = :en
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

require 'bundler/setup'

require 'active_support/json'
require 'active_support/core_ext/hash'
require 'eventmachine'
require 'em-http-request'
require 'pusher'
require 'thin'
require 'slanger_helper_methods'
require 'have_attributes'
require 'openssl'
require 'socket'
require 'timecop'
require 'pry'
require 'webmock/rspec'
require 'slanger'

WebMock.disable!

module Slanger; end

def errback
  @errback ||= Proc.new { |e| fail 'cannot connect to slanger. your box might be too slow. try increasing sleep value in the before block' }
end

RSpec.configure do |config|
  config.formatter = 'documentation'
  config.color = true
  config.mock_framework = :mocha
  config.order = 'random'
  config.include SlangerHelperMethods
  config.fail_fast = true
  config.after(:each) { stop_slanger if @server_pid }
  config.before :all do
    Pusher.tap do |p|
      p.host   = '0.0.0.0'
      p.port   = 4567
      p.app_id = '478158'
      p.secret = '592zxq4g45gg36nopi775ddh'
      p.key    = 'f23fou402gh7ezono99'
    end
  end
end