# -*- encoding: utf-8 -*-
require File.expand_path('../lib/monetico/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["zaiste"]
  gem.email         = ["oh@zaiste.net"]
  gem.homepage      = "http://dev.zaiste.net/monetico"
  gem.description   = %q{Your favourite money related calculations with Ruby}
  gem.summary       = %q{Basic calcz for everything money related}

  gem.add_development_dependency("rake")
  gem.add_development_dependency("bundler")

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.name          = "monetico"
  gem.require_paths = ["lib"]
  gem.version       = Monetico::VERSION
end
