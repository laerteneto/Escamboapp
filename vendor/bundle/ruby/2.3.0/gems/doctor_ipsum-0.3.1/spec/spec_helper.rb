require 'rubygems'
require 'bundler/setup'

RSpec.configure do |config|
  # Fail Fast
  config.fail_fast = true

  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include RSpec::Matchers

  # == Mock Framework
  config.mock_framework = :rspec
end
