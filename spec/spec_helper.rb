require 'minitest/autorun'
require 'uk_mail'
require 'byebug'

UKMail.configure do |config|
  spec_path = File.dirname(__FILE__)
  config.postcode_dat_path = spec_path + '/fixtures/postcode_sample.dat'
end
