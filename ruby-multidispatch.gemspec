# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-multidispatch"
  spec.version       = Multidispatch::VERSION
  spec.authors       = ["Iaroslav Sergieiev"]
  spec.email         = ["noomorph@gmail.com"]
  spec.description   = %q{
    Very basic multidispatch in Ruby using natural def syntax.
  }
  spec.summary       = %q{
    Very basic multidispatch in Ruby using natural def syntax.
    Currently supports only overloads by count of mandatory parameters.
  }
  spec.homepage      = "https://github.com/noomorph/ruby-multidispatch"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
