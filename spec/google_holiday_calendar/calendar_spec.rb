describe GoogleHolidayCalendar::Calendar do
  describe "#holidays" do
    subject{ calendar.holidays(start_date: start_date, end_date: end_date, limit: limit) }

    let(:limit)     { 10 }
    let(:start_date){ "2014-01-01" }
    let(:end_date)  { "2014-01-31" }

    context "Without country and lang" do
      let(:calendar){ GoogleHolidayCalendar::Calendar.new }

      its(:count){ should > 0 }
    end

    context "With country and lang" do
      let(:calendar){ GoogleHolidayCalendar::Calendar.new(country: country, lang: lang) }

      context "When holidays in Japan" do
        let(:country)   { "japanese" }
        let(:lang)      { "ja" }

        context "When args are YYYY-MM-DD" do
          let(:start_date){ "2014-01-01" }
          let(:end_date)  { "2014-01-31" }

          it_behaves_like :holidays_in_japan_at_jan
        end

        context "When args are instance" do
          let(:start_date){ date("2014-01-01") }
          let(:end_date)  { date("2014-01-31") }

          it_behaves_like :holidays_in_japan_at_jan
        end

        context "Without start_date and end_date" do
          let(:start_date){ nil }
          let(:end_date)  { nil }

          before do
            time_travel_to "2014-01-01"
          end

          it_behaves_like :holidays_in_japan_at_jan
        end

        context "When not found holidays" do
          let(:start_date){ "2014-06-01" }
          let(:end_date)  { "2014-07-01" }

          it{ should  == []}
        end
      end

      context "When holidays in America" do
        let(:country)   { "usa" }
        let(:lang)      { "en" }

        it_behaves_like :holidays_in_usa_at_jan
      end
    end
  end
end
