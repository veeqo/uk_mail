require 'uk_mail/version'
require 'uk_mail/session'
require 'uk_mail/shipping_services'
require 'uk_mail/postcode_data'

require 'uk_mail/soap_service/authentication'
require 'uk_mail/soap_service/collection'
require 'uk_mail/soap_service/consignment'

require 'uk_mail/service/base'
require 'uk_mail/service/authentication'
require 'uk_mail/service/collection'
require 'uk_mail/service/consignment'

module UKMail
  def self.configure(&block)
    yield @config ||= Configuration.new
  end

  def self.config
    @config
  end

  class Configuration
    attr_accessor :env
    attr_accessor :postcode_dat_path
  end

  configure do |config|
      config.env = :test
      config.postcode_dat_path = 'Postcode.dat'
    end
end
