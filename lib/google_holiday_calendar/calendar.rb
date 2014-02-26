module GoogleHolidayCalendar
  require 'open-uri'

  class Calendar
    attr_reader :country, :lang

    # @param country [String]
    # @param lang    [String]
    def initialize(country: "usa", lang: "en")
      @country = country.downcase
      @lang    = lang.downcase
    end

    # get holidays via google calendar
    # @param start_date [String,Date] start date ("YYYY-MM-DD" or Date). default: current date
    # @param end_date   [String,Date] end date ("YYYY-MM-DD" or Date). not contain this date. default: 1 month after the start_date
    # @param limit      [Integer]
    # @return [Hash] key: date, value: holiday title
    # @return [{}]   if found no holidays, return empty hash
    def holidays(start_date: nil, end_date: nil, limit: 10)
      start_date = Date.today unless start_date
      end_date = to_date(start_date) + 1.month unless end_date

      url = "http://www.google.com/calendar/feeds/#{@country}__#{@lang}@holiday.calendar.google.com/public/full?"
      params = {
          "alt"         => "json",
          "start-min"   => to_ymd(start_date),
          "start-max"   => to_ymd(end_date),
          "max-results" => limit,
      }
      url += params.to_query

      calendar_response = fetch(url)

      entries = calendar_response["feed"]["entry"]
      return {} unless entries

      holidays = entries.inject({}){ |res, entry|
        date = Date.parse(entry["gd$when"][0]["startTime"])
        title = entry["title"]["$t"]
        res[date] =title
        res
      }

      Hash[holidays.sort_by{|k,v| k }]
    end

    # whether arg is holiday
    # @param arg [#to_date, String] {Date}, {Time}, or date like String (ex. "YYYY-MM-DD")
    def holiday?(arg)
      date = to_date(arg)
      holidays(start_date: date, end_date: date + 1.day, limit: 1).length > 0
    end

    private

    # @param url [String]
    # @return [Hash]
    def fetch(url)
      json_response = URI.parse(url).read
      JSON.parse(json_response)
    end

    # @param arg [Date,String]
    # @return [String] YYYY-MM-DD
    def to_ymd(arg)
      date = to_date(arg)
      date.strftime("%Y-%m-%d")
    end

    # @param arg [Date,String]
    # @return [Date]
    def to_date(arg)
      if arg.is_a?(String)
        Date.parse(arg)
      elsif arg.respond_to?(:to_date)
        arg.to_date
      else
        arg
      end
    end
  end
end
