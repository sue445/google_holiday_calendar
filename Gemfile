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
  
  # NOTE: rexml v3.2.5+ requires Ruby 2.1.0+
  # https://github.com/ruby/rexml/compare/v3.2.4...v3.2.5#diff-f8c7cdefc29090ed525a2be70411ce741d4124853cf6425db7d18a6ea3bb9bb3R515
  gem "rexml", "< 3.2.5"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.2.0")
  # NOTE: rake v13.0.0+ requires Ruby 2.2.0+
  gem "rake", "< 13.0.0"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.2.0")
  # NOTE: minitest v5.12.1+ requires Ruby 2.2.0+
  gem "minitest", "< 5.12.1"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.5.0")
  # NOTE: docile 1.4.0+ requires Ruby 2.5.0+
  gem "docile", "< 1.4.0"
end
