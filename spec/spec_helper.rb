require 'simplecov'
SimpleCov.start 'rails' do
  coverage_dir 'public/coverage/rspec'
end

require 'rubygems'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'valid_attribute'
require 'vcr'

VCR.config do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.stub_with                :webmock
  c.default_cassette_options = { erb: true, record: :new_episodes } 
  # If you want to allow new VCR tapes to be recorded, add 
  # :record => :new_episodes to the default options.

  c.filter_sensitive_data('<OCLC_WSKEY>') { APP_CONFIG['oclc']['wskey'] }
  c.filter_sensitive_data('<AMAZON_ACCESS_KEY>') { APP_CONFIG['amazon']['access_key'] }
  c.filter_sensitive_data('<AMAZON_ASSOCIATE_TAG>') { APP_CONFIG['amazon']['associate_tag'] }
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.include Devise::TestHelpers, type: :controller
end
