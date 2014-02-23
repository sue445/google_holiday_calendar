shared_examples :holidays_in_usa_at_jan do
  its(:count){ should == 2 }
  it{ should include(date("2014-01-01") => "New Year's Day") }
  it{ should include(date("2014-01-20") => "Martin Luther King Day") }
end
