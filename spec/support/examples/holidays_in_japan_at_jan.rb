shared_examples :holidays_in_japan_at_jan do
  its(:count){ should == 2 }
  it{ should include(date("2014-01-01") => "元日") }
  it{ should include(date("2014-01-13") => "成人の日") }
end
