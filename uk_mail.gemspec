# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uk_mail/version'

Gem::Specification.new do |spec|
  spec.name          = "uk_mail"
  spec.version       = UKMail::VERSION
  spec.authors       = ["Luke Farmer"]
  spec.summary       = %q{UK Mail API for Ruby}
  spec.homepage      = "https://github.com/lefarmer/uk_mail"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency "soap4r-ng", "~> 2.0.4"
  spec.add_dependency "httpclient", "~> 2.6"
  spec.add_dependency "logger-application", "~> 0.0.2"

  spec.add_development_dependency "vcr", "~> 3.0.1"
  spec.add_development_dependency "webmock", "~> 2.0.0"
end
