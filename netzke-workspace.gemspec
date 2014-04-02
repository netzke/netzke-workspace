# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'netzke/workspace/version'

Gem::Specification.new do |spec|
  spec.name          = "netzke-workspace"
  spec.version       = Netzke::Workspace::VERSION
  spec.authors       = ["Max Gorin"]
  spec.email         = ["gorinme@gmail.com"]
  spec.summary       = %q{Netzke Workspace component}
  spec.description   = %q{Dynamically loads components in persisted tabs}
  spec.homepage      = "http://netzke.org"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'netzke-core', '0.10.0.rc2'

  spec.add_development_dependency 'rails', '~> 4.0.0'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'coffee-script'
  # spec.add_development_dependency 'netzke-testing', '0.10.0.rc1'
  spec.add_development_dependency 'rspec-rails'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
