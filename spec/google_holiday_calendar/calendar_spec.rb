describe GoogleHolidayCalendar::Calendar do
  let(:google_api_key) { "AAAAAAAA" }

  describe "#holidays" do
    subject{ calendar.holidays(start_date: start_date, end_date: end_date, limit: limit) }

    let(:limit)     { 10 }
    let(:start_date){ "2017-01-01" }
    let(:end_date)  { "2017-01-31" }

    before do
      # 2017-01-01 ~ 2017-01-31
      stub_request(:get, "https://www.googleapis.com/calendar/v3/calendars/ja.japanese%23holiday@group.v.calendar.google.com/events?key=#{google_api_key}&maxResults=10&timeMax=2017-01-31T00:00:00Z&timeMin=2017-01-01T00:00:00Z#{google_api_key}&maxResults=10&timeMax=2017-01-31T00:00:00Z&timeMin=2017-01-01T00:00:00Z").
        with(headers: {"Accept" => "*/*", "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3", "User-Agent" => "Ruby"}).
        to_return(status: 200, body: read_fixture("holidays_in_japan_at_jan.json"), headers: {})

      # 2017-01-01 ~ 2017-02-01
      stub_request(:get, "https://www.googleapis.com/calendar/v3/calendars/ja.japanese%23holiday@group.v.calendar.google.com/events?key=#{google_api_key}&maxResults=10&timeMax=2017-02-01T00:00:00Z&timeMin=2017-01-01T00:00:00Z").
        with(headers: {"Accept" => "*/*", "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3", "User-Agent" => "Ruby"}).
        to_return(status: 200, body: read_fixture("holidays_in_japan_at_jan.json"), headers: {})

      # 2017-01-01 ~ 2017-01-31
      stub_request(:get, "https://www.googleapis.com/calendar/v3/calendars/en.usa%23holiday@group.v.calendar.google.com/events?key=#{google_api_key}&maxResults=10&timeMax=2017-01-31T00:00:00Z&timeMin=2017-01-01T00:00:00Z").
        with(headers: {"Accept" => "*/*", "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3", "User-Agent" => "Ruby"}).
        to_return(status: 200, body: read_fixture("holidays_in_usa_at_jan.json"), headers: {})

    end
    context "Without country and lang" do
      let(:calendar){ GoogleHolidayCalendar::Calendar.new(api_key: google_api_key) }

      its(:count){ should > 0 }
    end

    context "With country and lang" do
      let(:calendar){ GoogleHolidayCalendar::Calendar.new(country: country, lang: lang, api_key: google_api_key) }

      context "When holidays in Japan" do
        let(:country)   { "japanese" }
        let(:lang)      { "ja" }

        context "When args are YYYY-MM-DD" do
          let(:start_date){ "2017-01-01" }
          let(:end_date)  { "2017-01-31" }

          it_behaves_like :holidays_in_japan_at_jan
        end

        context "When args are instance" do
          let(:start_date){ date("2017-01-01") }
          let(:end_date)  { date("2017-01-31") }

          it_behaves_like :holidays_in_japan_at_jan
        end

        context "Without start_date and end_date" do
          let(:start_date){ nil }
          let(:end_date)  { nil }

          before do
            time_travel_to "2017-01-01"
          end

          it_behaves_like :holidays_in_japan_at_jan
        end
      end

      context "When holidays in America" do
        let(:country)   { "usa" }
        let(:lang)      { "en" }

        it_behaves_like :holidays_in_usa_at_jan
      end
    end
  end

  describe "#holiday?" do
    subject{ calendar.holiday?(date) }

    let(:calendar){ GoogleHolidayCalendar::Calendar.new(country: country, lang: lang, api_key: google_api_key) }
    let(:country) { "japanese" }
    let(:lang)    { "ja" }

    before do
      # 2017-01-01 ~ 2017-01-02
      stub_request(:get, "https://www.googleapis.com/calendar/v3/calendars/ja.japanese%23holiday@group.v.calendar.google.com/events?key=#{google_api_key}&maxResults=1&timeMax=2017-01-02T00:00:00Z&timeMin=2017-01-01T00:00:00Z").
        with(headers: {"Accept" => "*/*", "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3", "User-Agent" => "Ruby"}).
        to_return(status: 200, body: read_fixture("holidays_in_japan_from_20170101_to_20170102.json"), headers: {})

      # 2017-02-01 ~ 2017-02-02
      stub_request(:get, "https://www.googleapis.com/calendar/v3/calendars/ja.japanese%23holiday@group.v.calendar.google.com/events?key=#{google_api_key}&maxResults=1&timeMax=2017-02-02T00:00:00Z&timeMin=2017-02-01T00:00:00Z").
        with(headers: {"Accept" => "*/*", "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3", "User-Agent" => "Ruby"}).
        to_return(status: 200, body: read_fixture("holidays_in_japan_from_20170201_to_20170202.json"), headers: {})
    end

    context "arg is holiday" do
      let(:date){ Date.parse("2017-01-01") }

      it{ should be true }
    end

    context "arg is not holiday" do
      let(:date){ Date.parse("2017-02-01") }

      it{ should be false }
    end
  end
end
