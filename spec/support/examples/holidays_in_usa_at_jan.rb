shared_examples :holidays_in_usa_at_jan do
  its(:count){ should == 3 }
  it{ should include(date("2017-01-01") => "New Year's Day") }
  it{ should include(date("2017-01-02") => "New Year's Day observed") }
  it{ should include(date("2017-01-16") => "Martin Luther King Day") }
end
