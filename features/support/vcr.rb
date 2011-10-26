require 'vcr'
VCR.config do |c|
  c.cassette_library_dir = 'features/cassettes'
  c.stub_with :webmock
  c.default_cassette_options = { record: :new_episodes, erb: true }

  c.allow_http_connections_when_no_cassette = true
end
VCR.turn_off!
