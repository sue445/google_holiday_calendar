if ENV["COVERAGE"]
  require 'coveralls'
  Coveralls.wear!
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'google_holiday_calendar'

require 'rspec'
require 'rspec/its'
require 'rspec/collection_matchers'
require 'delorean'
require 'webmock/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include Delorean

  config.after(:each) do
    back_to_the_present
  end
end

def spec_dir
  Pathname(__dir__)
end

def fixture_dir
  spec_dir.join("fixtures")
end
