# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'badge_hunter/version'

Gem::Specification.new do |spec|
  spec.name          = 'badge_hunter'
  spec.version       = BadgeHunter::VERSION
  spec.authors       = ['Bartosz Zurkowski']
  spec.email         = ['zurkowski.bartosz@gmail.com']

  spec.summary       = %q{Helps slaying ugly monsters and earning precious badges}
  spec.description   = %q{Helps slaying ugly monsters and earning precious badges}
  spec.homepage      = 'https://github.com/bzurkowski/badge_hunter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'capybara'
  spec.add_dependency 'capybara-angular'
  spec.add_dependency 'poltergeist'
  spec.add_dependency 'phantomjs'
  spec.add_dependency 'dotenv'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
end
