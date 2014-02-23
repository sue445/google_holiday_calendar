# GoogleHolidayCalendar [![Build Status](https://travis-ci.org/sue445/google_holiday_calendar.png?branch=master)](https://travis-ci.org/sue445/google_holiday_calendar) [![Coverage Status](https://coveralls.io/repos/sue445/google_holiday_calendar/badge.png)](https://coveralls.io/r/sue445/google_holiday_calendar) [![Dependency Status](https://gemnasium.com/sue445/google_holiday_calendar.png)](https://gemnasium.com/sue445/google_holiday_calendar)

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

## Usage (via ruby)

```ruby
require "google_holiday_calendar"

usa_calendar = GoogleHolidayCalendar::Calendar.new(country: "usa", lang: "en")

usa_calendar.holidays(start_date: "2014-01-01", end_date: "2014-03-01, limit: 5")
# => {Wed, 01 Jan 2014=>"New Year's Day", Mon, 20 Jan 2014=>"Martin Luther King Day", Fri, 14 Feb 2014=>"Valentine's Day", Mon, 17 Feb 2014=>"Presidents' Day (Washington's Birthday)"}

japan_calendar = GoogleHolidayCalendar::Calendar.new(country: "japanese", lang: "ja")

japan_calendar.holidays(start_date: "2014-01-01", end_date: "2014-03-01, limit: 5")
# => {Wed, 01 Jan 2014=>"元日", Thu, 02 Jan 2014=>"銀行休業日", Fri, 03 Jan 2014=>"銀行休業日", Mon, 13 Jan 2014=>"成人の日", Tue, 11 Feb 2014=>"建国記念の日"}
```

## Usage (via bash)

```sh
# get holidays (today - 1 month after)
$ date +"%Y-%m-%d"
2014-02-24

$ google_holiday_calendar
2014-03-09: Daylight Saving Time starts

# get holidays (2014/01/01 - 2014/07/01)
$ google_holiday_calendar --start-date=2014-01-01 --end-date=2014-07-01
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

# get holidays (with limit)
$ google_holiday_calendar --start-date=2014-01-01 --end-date=2014-07-01 --limit=3
google_holiday_calendar --start-date=2014-01-01 --end-date=2014-07-01 --limit=3
2014-02-14: Valentine's Day
2014-02-17: Presidents' Day (Washington's Birthday)
2014-04-13: Thomas Jefferson's Birthday

# get holidays (specify country and language)
$ google_holiday_calendar --start-date=2014-01-01 --end-date=2014-07-01 --country=japanese --lang=ja
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

## Contributing

1. Fork it ( http://github.com/sue445/google_holiday_calendar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
