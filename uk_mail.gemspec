# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uk_mail/version'

Gem::Specification.new do |spec|
  spec.name          = "uk_mail"
  spec.version       = UKMail::VERSION
  spec.authors       = ["Luke Farmer"]
  spec.email         = ["luke.e.farmer@gmail.com"]
  spec.summary       = %q{UK Mail API for Ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rubyjedi-soap4r", "~> 2.0.2.1"
  spec.add_development_dependency "vcr", "~> 3.0.1"
  spec.add_development_dependency "webmock", "~> 2.0.0"
end
