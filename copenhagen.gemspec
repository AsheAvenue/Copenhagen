# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'copenhagen/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Tim Boisvert, Ashe Avenue"]
  gem.email         = ["tboisvert@asheavenue.com"]
  gem.description   = %q{Extremely opinionated deploy framework for orgs that already have an established deploy process}
  gem.summary       = %q{Extremely opinionated deploy framework for people who already have an established deploy process}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = ["dip"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "copenhagen"
  gem.require_paths = ["lib"]
  gem.version       = Copenhagen::VERSION

  gem.add_dependency("net-ssh")
  gem.add_dependency("git")
end
