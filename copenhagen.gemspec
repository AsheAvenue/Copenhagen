# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'copenhagen/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Tim Boisvert, Ashe Avenue"]
  gem.email         = ["tboisvert@asheavenue.com"]
  gem.description   = %q{Extremely opinionated deploy framework for people who already have a deploy process}
  gem.summary       = %q{Extremely opinionated deploy framework for people who already have a deploy process}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = ["dip"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "Copenhagen"
  gem.require_paths = ["lib"]
  gem.version       = Copenhagen::VERSION
end