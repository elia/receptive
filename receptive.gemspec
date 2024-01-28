# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "receptive/version"

Gem::Specification.new do |spec|
  spec.name          = "receptive"
  spec.version       = Receptive::VERSION
  spec.authors       = ["Elia Schito"]
  spec.email         = ["elia@schito.me"]

  spec.summary       = %q{The perfect toolkit to lighten up your existing HTML}
  spec.homepage      = "https://github.com/elia/receptive#readme"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "opal", ["~> 1.0"]
  spec.add_dependency "opal-jquery", ["~> 0.5"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 13"
  spec.add_development_dependency "minitest"
end
