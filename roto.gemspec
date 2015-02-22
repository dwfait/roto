# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'roto/version'

Gem::Specification.new do |spec|
  spec.name          = "roto"
  spec.version       = Roto::VERSION
  spec.authors       = ["Dwain Faithfull"]
  spec.email         = ["dwfaithfull@gmail.com"]
  spec.summary       = %q{A token encryption library comparable to JWE}
  spec.description   = %q{Want to share a token of user data between services?
    Want to ensure it hasn't been tampered with? Use roto.}
  spec.homepage      = "https://github.com/dwfait/roto"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
