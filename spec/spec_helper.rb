require 'minitest/autorun'
require 'uk_mail'

UKMail.configure do |config|
  spec_path = File.dirname(__FILE__)
  config.env = :test
  config.postcode_dat_path = spec_path + '/fixtures/postcode_sample.dat'
end
