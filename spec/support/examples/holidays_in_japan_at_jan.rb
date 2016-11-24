shared_examples :holidays_in_japan_at_jan do
  its(:count){ should eq 3 }
  it{ should include(date("2017-01-01") => "元日") }
  it{ should include(date("2017-01-02") => "元日 振替休日") }
  it{ should include(date("2017-01-09") => "成人の日") }
end
