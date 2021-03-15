require 'vcr'
require 'webmock/rspec'
require 'uk_mail'

spec_path = File.dirname(__FILE__) + '/'

RSpec.configure do |config|
  config.before do
    UKMail.configure do |config|
      config.env = :test
      config.postcode_data_path = spec_path + 'fixtures/postcode_sample.dat'
    end
  end
end

VCR.configure do |config|
  config.configure_rspec_metadata!
  config.hook_into :webmock
  config.cassette_library_dir = spec_path + 'vcr_cassettes'
  config.filter_sensitive_data('TEST_USERNAME') { ENV['TEST_USERNAME'] }
  config.filter_sensitive_data('TEST_PASSWORD') { ENV['TEST_PASSWORD'] }
  config.filter_sensitive_data('TEST_AUTH_TOKEN') { ENV['TEST_AUTH_TOKEN'] }
  config.filter_sensitive_data('TEST_API_KEY') { ENV['TEST_API_KEY'] }
end
