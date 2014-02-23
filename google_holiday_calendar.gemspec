# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google_holiday_calendar/version'

Gem::Specification.new do |spec|
  spec.name          = "google_holiday_calendar"
  spec.version       = GoogleHolidayCalendar::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]
  spec.summary       = %q{Get holiday via Google Calendar.}
  spec.description   = %q{Get holiday via Google Calendar.}
  spec.homepage      = "https://github.com/sue445/google_holiday_calendar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "3.0.0.beta1"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "delorean"
end
