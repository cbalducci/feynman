# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'feynman/version'

Gem::Specification.new do |spec|
  spec.name          = "feynman"
  spec.version       = Feynman::VERSION
  spec.authors       = ["Cristiano Balducci"]
  spec.email         = ["cristiano.balducci@gmail.com"]
  spec.summary       = %q{A simple HTTP proxy}
  spec.description   = %q{Feynman is a simple HTTP proxy capable of JIT
  summoning of back-end containers. The concept has been loosely based on JITSU
  https://github.com/mirage/jitsu}
  spec.homepage      = "https://github.com/cbalducci/feynman"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
