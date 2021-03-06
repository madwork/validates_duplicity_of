# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'validates_duplicity_of/version'

Gem::Specification.new do |spec|
  spec.name          = "validates_duplicity_of"
  spec.version       = ValidatesDuplicityOf::VERSION
  spec.author        = "Vincent Durand"
  spec.email         = "vincent.durand@madwork.org"
  spec.description   = "ActiveRecord callback which handle the name duplication in your model."
  spec.summary       = "ActiveRecord callback which handle the name duplication in your model with ease."
  spec.homepage      = "https://github.com/madwork/validates_duplicity_of"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 2.3"
  spec.add_development_dependency "sqlite3-ruby"

  spec.add_runtime_dependency "activerecord", ">= 3.2"
end
