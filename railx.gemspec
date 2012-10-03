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

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  gem.require_paths = ["lib"]
end
