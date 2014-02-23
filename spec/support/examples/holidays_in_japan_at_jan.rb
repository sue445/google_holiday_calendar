shared_examples :holidays_in_japan_at_jan do
  its(:count){ should == 4 }
  it{ should include(date("2014-01-01") => "元日") }
  it{ should include(date("2014-01-02") => "銀行休業日") }
  it{ should include(date("2014-01-03") => "銀行休業日") }
  it{ should include(date("2014-01-13") => "成人の日") }
end
