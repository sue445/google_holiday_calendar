source 'https://rubygems.org'

# Specify your gem's dependencies in google_holiday_calendar.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.2.2")
  gem "activesupport", "< 5.0.0"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.1.0")
  group :test do
    gem "public_suffix", "< 3.0.0"
  end
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.2.0")
  # NOTE: rake v13.0.0+ requires Ruby 2.2.0+
  gem "rake", "< 13.0.0"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.2.0")
  # NOTE: minitest v5.12.1+ requires Ruby 2.2.0+
  gem "minitest", "< 5.12.1"
end
