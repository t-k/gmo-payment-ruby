VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = { :record => :new_episodes }
   c.filter_sensitive_data('<SHOP_ID>') { SPEC_CONF["shop_id"] }
   c.filter_sensitive_data('<SHOP_PASS>') { SPEC_CONF["shop_pass"] }
   c.filter_sensitive_data('<SITE_ID>') { SPEC_CONF["site_id"] }
   c.filter_sensitive_data('<SITE_PASS>') { SPEC_CONF["site_pass"] }
   c.filter_sensitive_data('<SITE_PASS>') { SPEC_CONF["site_pass"] }
   c.filter_sensitive_data('<ACCESS_ID>') { ACCESS_ID }
   c.filter_sensitive_data('<ACCESS_PASS>') { ACCESS_PASS }
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").gsub(/[^\w\/]+/, "_")
    VCR.use_cassette(name) { example.call }
  end
end