begin
  require 'bundler/setup'
rescue LoadError
  puts 'Although not required, bundler is recommended for running the tests.'
end
# load the library
require 'gmo'
require 'rspec'
require 'vcr'
require 'rack/test'
require 'support/config_loader'
require 'support/factory'
require 'support/vcr'

RSpec.configure do |config|
  config.mock_with :rspec
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end