# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'railx/version'

Gem::Specification.new do |gem|
  gem.name          = "railx"
  gem.version       = Railx::VERSION
  gem.authors       = ["Paolo Sechi"]
  gem.email         = ["sekipaolo@gmail.com"]
  gem.description   = %q{Give ajax functionality to a rails app using jquery}
  gem.summary       = %q{Give ajax functionality to a rails app using jquery}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
