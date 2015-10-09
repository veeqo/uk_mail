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

  spec.add_dependency "activesupport", ">= 3.0.0"

  # TODO: Added by bundler, Are they needed?
  #spec.add_development_dependency "bundler", "~> 1.7"
  #spec.add_development_dependency "rake", "~> 10.0"
end
