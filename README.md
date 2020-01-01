# GoogleHolidayCalendar

[![Gem Version](https://badge.fury.io/rb/google_holiday_calendar.png)](http://badge.fury.io/rb/google_holiday_calendar)
[![Build Status](https://github.com/sue445/google_holiday_calendar/workflows/test/badge.svg?branch=master)](https://github.com/sue445/google_holiday_calendar/actions?query=workflow%3Atest)
[![Coverage Status](https://coveralls.io/repos/sue445/google_holiday_calendar/badge.png)](https://coveralls.io/r/sue445/google_holiday_calendar)
[![Code Climate](https://codeclimate.com/github/sue445/google_holiday_calendar.png)](https://codeclimate.com/github/sue445/google_holiday_calendar)

Get holidays via Google Calendar.

## Requirements
* ruby 2.0.0+

## Installation

Add this line to your application's Gemfile:

    gem 'google_holiday_calendar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google_holiday_calendar

## Getting API key
### 1. Create GCP project
https://console.cloud.google.com/projectcreate

![create-project](img/create-project.png)

### 2. Go to credentials
![dashboard](img/dashboard.png)

### 3. Create credential with API key
![create-credential](img/create-credential.png)

### 4. Enable restrictions (Optional)
Click RESTRICT KEY

![api-key-created](img/api-key-created.png)

e.g. "IP addresses" in Application restrictions

![application-restrictions](img/application-restrictions.png)

### 5. Enable calendar API
Go to Library

![dashboard-library](img/dashboard-library.png)

Search with "Calendar" and enable "Google Calendar API".

![search-apis](img/search-apis.png)

![enable-google-calendar-api](img/enable-google-calendar-api.png)

## Usage (via ruby)

```ruby
require "google_holiday_calendar"

usa_calendar = GoogleHolidayCalendar::Calendar.new(country: "usa", lang: "en", api_key: "YOUR_API_KEY")

usa_calendar.holidays(start_date: "2014-01-01", end_date: "2014-03-01", limit: 5)
# => {Wed, 01 Jan 2014=>"New Year's Day", Mon, 20 Jan 2014=>"Martin Luther King Day", Fri, 14 Feb 2014=>"Valentine's Day", Mon, 17 Feb 2014=>"Presidents' Day (Washington's Birthday)"}

japan_calendar = GoogleHolidayCalendar::Calendar.new(country: "japanese", lang: "ja", api_key: "YOUR_API_KEY")

japan_calendar.holidays(start_date: "2014-01-01", end_date: "2014-03-01", limit: 5)
# => {Wed, 01 Jan 2014=>"元日", Thu, 02 Jan 2014=>"銀行休業日", Fri, 03 Jan 2014=>"銀行休業日", Mon, 13 Jan 2014=>"成人の日", Tue, 11 Feb 2014=>"建国記念の日"}

japan_calendar.holiday?("2014-01-01")
# => true

japan_calendar.holiday?("2014-02-01")
# => false
```

## Usage (via bash)

```sh
# get holidays (today - 1 month after)
$ date +"%Y-%m-%d"
2014-02-24

$ GOOGLE_API_KEY=xxxx google_holiday_calendar
2014-03-09: Daylight Saving Time starts
```

```sh
# get holidays (2014/01/01 - 2014/07/01)
$ GOOGLE_API_KEY=xxxx google_holiday_calendar --start-date=2014-01-01 --end-date=2014-07-01
2014-01-01: New Year's Day
2014-01-20: Martin Luther King Day
2014-02-14: Valentine's Day
2014-02-17: Presidents' Day (Washington's Birthday)
2014-03-09: Daylight Saving Time starts
2014-04-13: Thomas Jefferson's Birthday
2014-04-20: Easter Sunday
2014-05-11: Mothers' Day
2014-05-26: Memorial Day
2014-06-15: Fathers' Day
```

```sh
# get holidays (with limit)
$ GOOGLE_API_KEY=xxxx google_holiday_calendar --start-date=2014-01-01 --end-date=2014-07-01 --limit=3
2014-02-14: Valentine's Day
2014-02-17: Presidents' Day (Washington's Birthday)
2014-04-13: Thomas Jefferson's Birthday
```

```sh
# get holidays (specify country and language)
$ GOOGLE_API_KEY=xxxx google_holiday_calendar --start-date=2014-01-01 --end-date=2014-07-01 --country=japanese --lang=ja
2014-01-01: 元日
2014-01-02: 銀行休業日
2014-01-03: 銀行休業日
2014-01-13: 成人の日
2014-02-11: 建国記念の日
2014-03-21: 春分の日
2014-04-29: 昭和の日
2014-05-03: 憲法記念日
2014-05-04: みどりの日
2014-05-06: みどりの日 振替休日
```

## More reference
http://rubydoc.info/github/sue445/google_holiday_calendar

## Contributing

1. Fork it ( http://github.com/sue445/google_holiday_calendar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
