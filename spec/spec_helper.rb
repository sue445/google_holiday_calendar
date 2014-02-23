$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'google_holiday_calendar'

require 'rspec'
require 'rspec/its'
require 'rspec/collection_matchers'
require 'delorean'
require 'memoist'

require 'coveralls'
Coveralls.wear!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include Delorean

  config.after(:each) do
    back_to_the_present
  end

  config.before(:suite) do
    class GoogleHolidayCalendar::Calendar
      extend Memoist
      memoize :fetch
    end
  end
end
