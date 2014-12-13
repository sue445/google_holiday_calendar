module GoogleHolidayCalendar
  require 'open-uri'
  require 'cgi'

  class Calendar
    attr_reader :country, :lang

    # @param country [String]
    # @param lang    [String]
    def initialize(country: "usa", lang: "en", api_key: nil)
      @country = country.downcase
      @lang    = lang.downcase
      @api_key = api_key
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

      calendar_id = "#{@lang}.#{@country}#holiday@group.v.calendar.google.com"
      url = "https://www.googleapis.com/calendar/v3/calendars/#{CGI.escape(calendar_id)}/events?"
      params = {
        "key"         => @api_key,
        "timeMin"     => to_ymd(start_date),
        "timeMax"     => to_ymd(end_date),
        "maxResults" => limit,
      }
      url += params.to_query

      calendar_response = fetch(url)

      entries = calendar_response["items"]
      return {} unless entries

      holidays = entries.inject({}){ |res, item|
        date = Date.parse(item['start']['date'])
        title = item["summary"]
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
      date.strftime("%Y-%m-%d") + "T00:00:00Z"
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
