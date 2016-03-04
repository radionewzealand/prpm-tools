# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prpmtools/version'

Gem::Specification.new do |spec|
  spec.name          = "prpm-tools"
  spec.version       = PrpmTools::VERSION
  spec.authors       = ["Richard Hulse"]
  spec.email         = ["richard.hulse@radionz.co.nz"]

  spec.summary       = %q{Tools for parsing logs according the PRPM Guidlines}
  spec.homepage      = "https://github.com/radionewzealand/prpm-tools"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_dependency "nokogiri"

end
