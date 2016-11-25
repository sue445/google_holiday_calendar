def date(str)
  Date.parse(str)
end

def read_fixture(name)
  fixture_dir.join(name).read
end
